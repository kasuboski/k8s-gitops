package cmd

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestRemoveStaleAppDirs(t *testing.T) {
	root := t.TempDir()
	require.NoError(t, os.Mkdir(filepath.Join(root, "apps"), 0755))
	require.NoError(t, os.Mkdir(filepath.Join(root, "retired"), 0755))
	require.NoError(t, os.WriteFile(filepath.Join(root, "apps.json"), []byte("{}"), 0644))

	err := removeStaleAppDirs(root)

	require.NoError(t, err)
	assert.DirExists(t, filepath.Join(root, "apps"))
	assert.NoDirExists(t, filepath.Join(root, "retired"))
	assert.FileExists(t, filepath.Join(root, "apps.json"))
}
