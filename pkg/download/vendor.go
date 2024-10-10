package download

import (
	"context"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path"
	"path/filepath"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
)

type Vendor struct {
	Pkg       string
	Download  Download
	Kustomize Kustomize
}

type Download struct {
	Source string
}

type Kustomize struct {
	Path string
}

var vendorDir = "cue.mod/gen"

func DoVendor(ctx context.Context, vs []Vendor) error {
	var err error
	for _, v := range vs {
		if isKustomize(v) {
			err = errors.Join(err, VendorKustomize(ctx, v.Pkg, v.Kustomize))
		}
		if isDownload(v) {
			err = errors.Join(err, VendorDownload(ctx, v.Pkg, v.Download))
		}
	}
	return err
}

func isKustomize(v Vendor) bool {
	return v.Kustomize.Path != ""
}

func isDownload(v Vendor) bool {
	return v.Download.Source != ""
}

func VendorDownload(ctx context.Context, pkg string, d Download) error {
	out, err := createPkgDir(pkg)
	if err != nil {
		return err
	}

	file := path.Base(d.Source)
	err = DownloadSomething(d.Source, path.Join(out, file))
	if err != nil {
		return fmt.Errorf("failed to vendor download: %w", err)
	}
	b, err := os.ReadFile(path.Join(out, path.Base(d.Source)))
	if err != nil || len(b) == 0 {
		return fmt.Errorf("no file after download: %w", err)
	}

	err = ConvertYaml(ctx, out, pkg)
	if err != nil {
		return fmt.Errorf("couldn't convert downloaded yaml: %w", err)
	}
	return nil
}

func VendorKustomize(ctx context.Context, pkg string, k Kustomize) error {
	err := RunKustomize(ctx, pkg, k)
	if err != nil {
		return err
	}
	p := path.Join(vendorDir, pkg)
	err = ConvertYaml(ctx, p, pkg)
	if err != nil {
		return fmt.Errorf("couldn't convert kustomize output to cue: %w", err)
	}
	return nil
}

func RunKustomize(ctx context.Context, pkg string, k Kustomize) error {
	out, err := createPkgDir(pkg)
	if err != nil {
		return err
	}
	args := []string{"build", k.Path, "-o", out}
	c := exec.CommandContext(ctx, "kustomize", args...)
	o, err := c.CombinedOutput()
	if err != nil {
		return fmt.Errorf("failed running kustomize: %s", string(o))
	}
	return nil
}

func ConvertYaml(ctx context.Context, p string, pkg string) error {
	// cue import yaml -p secrets -f -l 'strings.ToLower(kind)' -l 'metadata.name' -R -i secrets/doppler-operator.yaml
	pkgName := path.Base(pkg)
	args := []string{"import", "yaml", "-p", pkgName, "-f", "-l", "strings.ToLower(kind)", "-l", "metadata.name", "-R", "-i", "."}
	c := exec.CommandContext(ctx, "cue", args...)
	f, err := relPath(p)
	if err != nil {
		return err
	}
	c.Dir = f
	// log.Println(c)
	o, err := c.CombinedOutput()
	if err != nil {
		return fmt.Errorf("failed running cue: %s: %w", string(o), err)
	}
	return nil
}

func relPath(p string) (string, error) {
	if !path.IsAbs(p) {
		return p, nil
	}
	wd, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("couldn't get workdir: %w", err)
	}

	f, err := filepath.Rel(wd, p)
	if err != nil {
		return "", fmt.Errorf("couldn't make path relative: %w", err)
	}

	return f, nil
}

func LoadVendor(path string) ([]Vendor, error) {
	v := loadCue(path)
	v = v.LookupPath(cue.ParsePath("vendorList"))

	var vend []Vendor
	err := v.Decode(&vend)
	if err != nil {
		return nil, fmt.Errorf("failed to decode vendor: %w", err)
	}

	return vend, nil
}

func createPkgDir(pkg string) (string, error) {
	out := path.Join(vendorDir, pkg)
	err := os.MkdirAll(out, 0755)
	if err != nil {
		return "", fmt.Errorf("couldn't create output dir: %w", err)
	}
	return out, nil
}

func loadCue(path string) cue.Value {
	ctx := cuecontext.New()
	insts := load.Instances([]string{path}, nil)
	v := ctx.BuildInstance(insts[0])
	return v
}
