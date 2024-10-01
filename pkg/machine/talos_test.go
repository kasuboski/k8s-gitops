package machine

import (
	"context"
	"fmt"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestReadClusterConfig(t *testing.T) {
	config := repoClusterConfig(t)

	require.NotNil(t, config)

	assert.NotEmpty(t, config.Nodes)

}

func TestTalosConfigInfoFromClusterConfig(t *testing.T) {
	config := repoClusterConfig(t)

	defaultPatches := DefaultNodePatches()
	for name, node := range config.Nodes {
		tc, err := TalosConfigInfoFromClusterConfig(defaultPatches, config, name)
		require.NoError(t, err)

		assert.Contains(t, tc.BaseConfigFilePath, node.Role)
		assert.Contains(t, tc.OutputFilePath, name)
		// testing for one is probably enough
		assert.Contains(t, tc.PatchFilePaths, defaultPatches[0])
		assert.Contains(t, tc.PatchFilePaths, node.Patches[0])
		assert.Contains(t, tc.PatchFilePaths, fmt.Sprintf("%s-patch.yaml", name))
	}

	_, err := TalosConfigInfoFromClusterConfig(defaultPatches, nil, "")
	assert.Error(t, err)

	_, err = TalosConfigInfoFromClusterConfig(defaultPatches, config, "random")
	assert.Error(t, err)
}

func TestMachineConfigPatchCmd(t *testing.T) {
	ctx := context.Background()
	tc := TalosMachineConfigInfo{
		BaseConfigFilePath: "base-config",
		OutputFilePath:     "output-file",
		PatchFilePaths:     []string{"patch1", "patch2"},
	}
	c := machineConfigPatchCmd(ctx, tc)
	args := strings.Join(c.Args, " ")
	assert.Contains(t, args, "talosctl")
	assert.Contains(t, args, "base-config")
	assert.Contains(t, args, "--output output-file")
	assert.Contains(t, args, "--patch @patch1")
	assert.Contains(t, args, "--patch @patch2")
}

func repoClusterConfig(t *testing.T) *ClusterConfig {
	repoConfig := "../../talos/cluster.yaml"
	config, err := ReadClusterConfig(repoConfig)
	require.NoError(t, err)

	return config
}
