package machine

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestLoadNodesFromCUE(t *testing.T) {
	nodes, err := loadNodesFromCUEWithPath("../../machines")
	require.NoError(t, err)
	require.NotNil(t, nodes)

	// Verify we have the expected nodes
	assert.Len(t, nodes, 5)
	assert.Contains(t, nodes, "cherry")
	assert.Contains(t, nodes, "blueberry")
	assert.Contains(t, nodes, "pumpkin")
	assert.Contains(t, nodes, "apple")
	assert.Contains(t, nodes, "adel")

	// Verify control plane node
	controlPlaneNodes := []string{"adel"}
	for _, name := range controlPlaneNodes {
		node, ok := nodes[name]
		require.True(t, ok, "node %s should exist", name)
		assert.Equal(t, "controlplane", node.Role)
		assert.NotEmpty(t, node.Patches, "node %s should have patches", name)
		// Control plane nodes should have multiple patches
		assert.Greater(t, len(node.Patches), 3, "control plane node %s should have multiple patches", name)
	}

	// Verify worker nodes
	workerNodes := []string{"cherry", "blueberry", "pumpkin", "apple"}
	for _, name := range workerNodes {
		node, ok := nodes[name]
		require.True(t, ok, "node %s should exist", name)
		assert.Equal(t, "worker", node.Role)
		assert.NotEmpty(t, node.Patches, "node %s should have patches", name)
	}
}

func TestCUENodeConfigPatches(t *testing.T) {
	nodes, err := loadNodesFromCUEWithPath("../../machines")
	require.NoError(t, err)

	// Test that patches are loaded as map[string]interface{}
	cherry := nodes["cherry"]
	require.NotEmpty(t, cherry.Patches)

	// Each patch should be a valid map
	for i, patch := range cherry.Patches {
		assert.IsType(t, map[string]interface{}{}, patch, "patch %d should be a map", i)
		// Patches should have either 'machine' or 'cluster' or other top-level keys
		assert.NotEmpty(t, patch, "patch %d should not be empty", i)
	}
}

func TestCUEValidation(t *testing.T) {
	// This test verifies that CUE files can be loaded without errors
	// If there were CUE syntax errors or type violations, loadNodesFromCUEWithPath would fail
	nodes, err := loadNodesFromCUEWithPath("../../machines")
	require.NoError(t, err, "CUE files should be valid and load without errors")
	require.NotNil(t, nodes)

	// Verify each node has required fields
	for name, node := range nodes {
		assert.NotEmpty(t, node.Role, "node %s should have a role", name)
		assert.Contains(t, []string{"controlplane", "worker"}, node.Role, "node %s should have valid role", name)
		assert.NotNil(t, node.Patches, "node %s should have patches (even if empty)", name)
	}
}
