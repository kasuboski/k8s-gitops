package machine

import (
	"context"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"gopkg.in/yaml.v3"
)

type CUENodeConfig struct {
	Role    string
	Patches []map[string]interface{}
}

// GenerateConfigsFromCUE generates Talos configs directly from CUE definitions
func GenerateConfigsFromCUE(ctx context.Context, clusterName, endpoint, secretsFile, outputDir string) error {
	// 1. Load nodes from CUE
	nodes, err := loadNodesFromCUE()
	if err != nil {
		return fmt.Errorf("load nodes from CUE: %w", err)
	}

	// 2. Generate base configs with talosctl
	secretsDir := filepath.Dir(secretsFile)
	if err := generateBaseConfigs(ctx, clusterName, endpoint, secretsFile, secretsDir); err != nil {
		return fmt.Errorf("generate base configs: %w", err)
	}

	// 3. Generate Tailscale extension config with Doppler substitution
	tailscaleConfig := filepath.Join(secretsDir, "tailscale-extensionconfig.yaml")
	if err := generateTailscaleConfig(ctx, tailscaleConfig); err != nil {
		// Warning only - Tailscale is optional
		fmt.Printf("Warning: Could not generate Tailscale config: %v\n", err)
	}

	// 4. For each node, write patches and apply them
	for nodeName, nodeConfig := range nodes {
		baseConfig := filepath.Join(secretsDir, nodeConfig.Role+".yaml")
		outputFile := filepath.Join(outputDir, nodeName+".yaml")

		// Write each patch to a temp file
		var patchArgs []string
		for i, patch := range nodeConfig.Patches {
			patchFile := filepath.Join(secretsDir, fmt.Sprintf(".%s-patch-%d.yaml", nodeName, i))
			patchData, err := yaml.Marshal(patch)
			if err != nil {
				return fmt.Errorf("marshal patch %d for %s: %w", i, nodeName, err)
			}
			if err := os.WriteFile(patchFile, patchData, 0644); err != nil {
				return fmt.Errorf("write patch file: %w", err)
			}
			defer os.Remove(patchFile) // Clean up temp patch file

			patchArgs = append(patchArgs, "--patch", "@"+patchFile)
		}

		// Add Tailscale extension config if it exists
		if _, err := os.Stat(tailscaleConfig); err == nil {
			patchArgs = append(patchArgs, "--patch", "@"+tailscaleConfig)
		}

		// Run talosctl machineconfig patch
		args := []string{"machineconfig", "patch", baseConfig}
		args = append(args, patchArgs...)
		args = append(args, "--output", outputFile)

		cmd := exec.CommandContext(ctx, "talosctl", args...)
		output, err := cmd.CombinedOutput()
		if err != nil {
			return fmt.Errorf("patch config for %s: %s: %w", nodeName, string(output), err)
		}

		fmt.Printf("Generated %s\n", outputFile)
	}

	return nil
}

func loadNodesFromCUE() (map[string]CUENodeConfig, error) {
	ctx := cuecontext.New()

	instances := load.Instances([]string{"./machines.cue"}, &load.Config{
		Dir: ".",
	})
	if len(instances) == 0 {
		return nil, fmt.Errorf("no CUE instances found")
	}

	if err := instances[0].Err; err != nil {
		return nil, fmt.Errorf("load CUE: %w", err)
	}

	v := ctx.BuildInstance(instances[0])
	if v.Err() != nil {
		return nil, fmt.Errorf("build CUE: %w", v.Err())
	}

	nodesValue := v.LookupPath(cue.ParsePath("nodes"))
	if nodesValue.Err() != nil {
		return nil, fmt.Errorf("lookup nodes: %w", nodesValue.Err())
	}

	nodes := make(map[string]CUENodeConfig)
	iter, err := nodesValue.Fields()
	if err != nil {
		return nil, fmt.Errorf("iterate nodes: %w", err)
	}

	for iter.Next() {
		nodeName := iter.Label()
		var nodeConfig CUENodeConfig
		if err := iter.Value().Decode(&nodeConfig); err != nil {
			return nil, fmt.Errorf("decode node %s: %w", nodeName, err)
		}
		nodes[nodeName] = nodeConfig
	}

	return nodes, nil
}

func generateBaseConfigs(ctx context.Context, clusterName, endpoint, secretsFile, outputDir string) error {
	cmd := exec.CommandContext(ctx, "talosctl", "gen", "config",
		"--with-secrets", secretsFile,
		clusterName,
		endpoint,
		"-o", outputDir,
		"--force")

	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("talosctl gen config: %s: %w", string(output), err)
	}

	return nil
}

func generateTailscaleConfig(ctx context.Context, outputFile string) error {
	// Run the substitute script from talos/ directory
	cmd := exec.CommandContext(ctx, "bash", "./substitute-tailscale.sh", outputFile)
	cmd.Dir = "talos"
	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("substitute tailscale config: %s: %w", string(output), err)
	}
	return nil
}
