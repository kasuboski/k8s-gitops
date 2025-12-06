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

type CUEClusterConfig struct {
	Name           string
	Endpoint       string
	NodeEndpoints  map[string]string
	TalosEndpoints []string
}

// GenerateConfigsFromCUE generates Talos configs directly from CUE definitions
func GenerateConfigsFromCUE(ctx context.Context, secretsFile, outputDir string) error {
	// 1. Load cluster config from CUE
	cluster, err := loadClusterFromCUE()
	if err != nil {
		return fmt.Errorf("load cluster from CUE: %w", err)
	}

	// 2. Load nodes from CUE
	nodes, err := loadNodesFromCUE()
	if err != nil {
		return fmt.Errorf("load nodes from CUE: %w", err)
	}

	// 3. Generate base configs with talosctl
	secretsDir := filepath.Dir(secretsFile)
	if err := generateBaseConfigs(ctx, cluster.Name, cluster.Endpoint, secretsFile, secretsDir); err != nil {
		return fmt.Errorf("generate base configs: %w", err)
	}

	// 4. Update talosconfig with proper endpoints
	talosconfigPath := filepath.Join(outputDir, "talosconfig")
	if err := updateTalosconfig(talosconfigPath, cluster); err != nil {
		return fmt.Errorf("update talosconfig: %w", err)
	}

	// 5. For each node, write patches and apply them
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

func loadClusterFromCUE() (*CUEClusterConfig, error) {
	return loadClusterFromCUEWithPath("./machines")
}

func loadClusterFromCUEWithPath(path string) (*CUEClusterConfig, error) {
	ctx := cuecontext.New()

	instances := load.Instances([]string{path}, nil)
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

	clusterValue := v.LookupPath(cue.ParsePath("cluster"))
	if clusterValue.Err() != nil {
		return nil, fmt.Errorf("lookup cluster: %w", clusterValue.Err())
	}

	var cluster CUEClusterConfig
	if err := clusterValue.Decode(&cluster); err != nil {
		return nil, fmt.Errorf("decode cluster: %w", err)
	}

	return &cluster, nil
}

func loadNodesFromCUE() (map[string]CUENodeConfig, error) {
	return loadNodesFromCUEWithPath("./machines")
}

func loadNodesFromCUEWithPath(path string) (map[string]CUENodeConfig, error) {
	ctx := cuecontext.New()

	instances := load.Instances([]string{path}, nil)
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

func updateTalosconfig(talosconfigPath string, cluster *CUEClusterConfig) error {
	// Read the generated talosconfig
	data, err := os.ReadFile(talosconfigPath)
	if err != nil {
		return fmt.Errorf("read talosconfig: %w", err)
	}

	// Parse as YAML
	var config map[string]interface{}
	if err := yaml.Unmarshal(data, &config); err != nil {
		return fmt.Errorf("unmarshal talosconfig: %w", err)
	}

	// Update the context with endpoints
	if contexts, ok := config["contexts"].(map[string]interface{}); ok {
		if clusterContext, ok := contexts[cluster.Name].(map[string]interface{}); ok {
			clusterContext["endpoints"] = cluster.TalosEndpoints
		}
	}

	// Write back
	updatedData, err := yaml.Marshal(config)
	if err != nil {
		return fmt.Errorf("marshal talosconfig: %w", err)
	}

	if err := os.WriteFile(talosconfigPath, updatedData, 0600); err != nil {
		return fmt.Errorf("write talosconfig: %w", err)
	}

	return nil
}
