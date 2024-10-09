package manifests

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAppsResources(t *testing.T) {
	b, err := AppsResources("../../")
	require.NoError(t, err)

	require.NotNil(t, b)
	assert.Contains(t, b, "ingress")
	assert.NotEmpty(t, b["ingress"])

	assert.Contains(t, b, "secrets")
	assert.NotEmpty(t, b["secrets"])
}

func TestArgoApps(t *testing.T) {
	b, err := ArgoApps("../../")
	require.NoError(t, err)

	require.NotNil(t, b)
	assert.NotEmpty(t, b)
}

func TestArgoAppsApp(t *testing.T) {
	b, err := ArgoAppsApp("../../")
	require.NoError(t, err)

	require.NotNil(t, b)
}
