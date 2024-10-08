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
}
