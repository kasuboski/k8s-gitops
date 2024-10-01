package machine

import (
	"context"
	"errors"
	"fmt"
	"os"
	"os/exec"

	"gopkg.in/yaml.v3"
)

const (
	baseControlConfig = "result/controlplane.yaml"
	baseWorkerConfig  = "result/worker.yaml"
)

type ClusterConfig struct {
	Nodes map[string]Node
}

type Node struct {
	Role    string
	Patches []string
}

// TalosMachineConfigInfo is the input to the talosctl machineconfig patch command
type TalosMachineConfigInfo struct {
	BaseConfigFilePath string
	PatchFilePaths     []string
	OutputFilePath     string
}

func ValidateMachineConfig(ctx context.Context, path string, mode string) error {
	args := []string{"validate", "--strict", "-c", path, "-m", mode}
	c := exec.CommandContext(ctx, "talosctl", args...)
	o, err := c.Output()
	if err != nil {
		return fmt.Errorf("%s: %w", o, err)
	}
	return nil
}

func GenerateMachineConfig(ctx context.Context, tc TalosMachineConfigInfo) error {
	c := machineConfigPatchCmd(ctx, tc)
	o, err := c.CombinedOutput()
	if err != nil {
		return fmt.Errorf("failed running talosctl: %s", string(o))
	}
	return nil
}

func machineConfigPatchCmd(ctx context.Context, tc TalosMachineConfigInfo) *exec.Cmd {
	args := []string{"machineconfig", "patch", tc.BaseConfigFilePath}
	args = append(args, patchesToArgs(tc.PatchFilePaths)...)
	args = append(args, []string{"--output", tc.OutputFilePath}...)

	return exec.CommandContext(ctx, "talosctl", args...)
}

func patchesToArgs(patches []string) []string {
	ret := make([]string, 0, len(patches))
	for _, p := range patches {
		ret = append(ret, "--patch", fmt.Sprintf("@%s", p))
	}

	return ret
}

func TalosConfigInfoFromClusterConfig(defaultNodePatches []string, clusterConfig *ClusterConfig, nodeName string) (*TalosMachineConfigInfo, error) {
	if clusterConfig == nil {
		return nil, errors.New("clusterConfig is required")
	}
	node, ok := clusterConfig.Nodes[nodeName]
	if !ok {
		return nil, fmt.Errorf("node %s isn't in the cluster config", nodeName)
	}

	nodePatches := append(defaultNodePatches, node.Patches...)
	nodePatches = append(nodePatches, fmt.Sprintf("%s-patch.yaml", nodeName))

	baseConfig := baseControlConfig
	if node.Role == "worker" {
		baseConfig = baseWorkerConfig
	}

	return &TalosMachineConfigInfo{
		BaseConfigFilePath: baseConfig,
		PatchFilePaths:     nodePatches,
		OutputFilePath:     fmt.Sprintf("result/%s.yaml", nodeName),
	}, nil
}

func ReadClusterConfig(filepath string) (*ClusterConfig, error) {
	bytes, err := os.ReadFile(filepath)
	if err != nil {
		return nil, fmt.Errorf("couldn't read config: %w", err)
	}

	var clusterConfig ClusterConfig
	err = yaml.Unmarshal(bytes, &clusterConfig)
	if err != nil {
		return nil, fmt.Errorf("couldn't parse config file: %w", err)
	}

	return &clusterConfig, nil
}

func DefaultNodePatches() []string {
	return []string{"kubelet-cert-patch.yaml", "kubelet-ip-patch.yaml", "vip-patch.yaml", "result/tailscale-extensionconfig.yaml"}
}
