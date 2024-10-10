package download

import (
	"context"
	"os"
	"path"
	"path/filepath"
	"testing"

	"cuelang.org/go/cue"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestLoadVendor(t *testing.T) {
	v, err := LoadVendor("../../")
	require.NoError(t, err)
	require.NotNil(t, v)

	assert.NotEmpty(t, v)
	for _, vend := range v {
		assert.NotEmpty(t, vend.Pkg)
	}
}

func TestRunKustomize(t *testing.T) {
	vendorDir = t.TempDir()
	ctx := context.Background()
	k := Kustomize{
		Path: "../../argocd",
	}
	err := RunKustomize(ctx, "github.com/testing/v1", k)
	require.NoError(t, err)
	assert.DirExists(t, path.Join(vendorDir, "github.com/testing/v1"))
	assert.FileExists(t, path.Join(vendorDir, "github.com/testing/v1/v1_service_argocd-server.yaml"))
}

func TestLoadYaml(t *testing.T) {
	ctx := context.Background()
	dir := t.TempDir()
	err := os.CopyFS(dir, os.DirFS("./testdata/argo_yaml"))
	require.NoError(t, err)

	wd, err := os.Getwd()
	require.NoError(t, err)
	rel, err := filepath.Rel(wd, dir)
	require.NoError(t, err)

	err = ConvertYaml(ctx, rel, "argo_yaml")
	require.NoError(t, err)

	assert.DirExists(t, dir)
	out := []string{"argocd-rbac-cm.cue", "default-project.cue", "ingress.cue", "namespace.cue"}
	for _, f := range out {
		assert.FileExists(t, path.Join(dir, f))
	}
}

func TestVendorKustomize(t *testing.T) {
	vendorDir = t.TempDir()
	ctx := context.Background()
	k := Kustomize{
		Path: "../../argocd",
	}

	pkg := "github.com/testing/v1"
	err := VendorKustomize(ctx, pkg, k)
	require.NoError(t, err)

	loc := path.Join(vendorDir, pkg)
	assert.DirExists(t, loc)

	v := loadCue(loc)
	require.NotNil(t, v)

	ing := v.LookupPath(cue.ParsePath("ingress.argocd"))
	assert.NotNil(t, ing)
}

func TestVendorDownload(t *testing.T) {
	vendorDir = t.TempDir()
	ctx := context.Background()
	absSrc, err := filepath.Abs("testdata/argo_yaml/default-project.yaml")
	require.NoError(t, err)
	// httpSrc := "https://github.com/envoyproxy/gateway/releases/download/v1.1.2/install.yaml"
	d := Download{
		Source: absSrc,
	}
	pkg := "github.com/testing/v1"
	err = VendorDownload(ctx, pkg, d)
	require.NoError(t, err)

	loc := path.Join(vendorDir, pkg)
	assert.DirExists(t, loc)

	v := loadCue(loc)
	require.NotNil(t, v)
}
