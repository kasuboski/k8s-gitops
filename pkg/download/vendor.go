package download

import (
	"context"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/load"
	"gopkg.in/yaml.v3"
)

type Helm struct {
	Chart        string
	Version      string
	Repo         string
	Values       map[string]interface{}
	ReleaseName  string
	Namespace    string
	IncludeCRDs  *bool
	SkipTests    *bool
}

type Vendor struct {
	Pkg       string
	Download  Download
	Kustomize Kustomize
	Helm      Helm
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
		if isHelm(v) {
			err = errors.Join(err, VendorHelm(ctx, v.Pkg, v.Helm))
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

func isHelm(v Vendor) bool {
	return v.Helm.Chart != ""
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

func VendorHelm(ctx context.Context, pkg string, h Helm) error {
	// Create output directory
	out, err := createPkgDir(pkg)
	if err != nil {
		return err
	}

	// Create temporary values file if values provided
	var valuesFile string
	if h.Values != nil && len(h.Values) > 0 {
		valuesFile, err = createTempValuesFile(h.Values)
		if err != nil {
			return fmt.Errorf("failed to create values file: %w", err)
		}
		defer os.Remove(valuesFile)
	}

	// Run helm template and write output to file
	err = RunHelmTemplate(ctx, pkg, out, h, valuesFile)
	if err != nil {
		return err
	}

	// Convert YAML to CUE (same as kustomize/download)
	p := path.Join(vendorDir, pkg)
	err = ConvertYaml(ctx, p, pkg)
	if err != nil {
		return fmt.Errorf("couldn't convert helm output to cue: %w", err)
	}

	return nil
}

func createTempValuesFile(values map[string]interface{}) (string, error) {
	// Marshal values to YAML
	b, err := yaml.Marshal(values)
	if err != nil {
		return "", fmt.Errorf("failed to marshal values: %w", err)
	}

	// Create temp file
	tmpFile, err := os.CreateTemp("", "helm-values-*.yaml")
	if err != nil {
		return "", fmt.Errorf("failed to create temp file: %w", err)
	}
	defer tmpFile.Close()

	// Write YAML data
	if _, err := tmpFile.Write(b); err != nil {
		os.Remove(tmpFile.Name())
		return "", fmt.Errorf("failed to write values: %w", err)
	}

	return tmpFile.Name(), nil
}

func RunHelmTemplate(ctx context.Context, pkg, outputDir string, h Helm, valuesFile string) error {
	// Release name is required in CUE schema
	releaseName := h.ReleaseName

	// Determine namespace (default to "default")
	namespace := h.Namespace
	if namespace == "" {
		namespace = "default"
	}

	// Build helm template command (no --output-dir, capture stdout)
	args := []string{
		"template",
		releaseName,
		h.Chart,
		"--namespace", namespace,
		"--dependency-update",
	}

	// Add optional flags
	if h.Version != "" {
		args = append(args, "--version", h.Version)
	}
	if h.Repo != "" {
		args = append(args, "--repo", h.Repo)
	}
	if valuesFile != "" {
		args = append(args, "--values", valuesFile)
	}
	if h.IncludeCRDs == nil || *h.IncludeCRDs {
		args = append(args, "--include-crds")
	} else {
		args = append(args, "--skip-crds")
	}
	if h.SkipTests == nil || *h.SkipTests {
		args = append(args, "--skip-tests")
	}

	// Execute command and capture stdout
	c := exec.CommandContext(ctx, "helm", args...)
	output, err := c.Output()
	if err != nil {
		// Get stderr for error message
		if exitErr, ok := err.(*exec.ExitError); ok {
			return fmt.Errorf("failed running helm template: %s: %w", string(exitErr.Stderr), err)
		}
		return fmt.Errorf("failed running helm template: %w", err)
	}

	// Split multi-document YAML into separate files
	if err := splitHelmYAML(output, outputDir); err != nil {
		return fmt.Errorf("failed splitting helm output: %w", err)
	}

	return nil
}

func splitHelmYAML(data []byte, outputDir string) error {
	// Parse multi-document YAML and write each document to a separate file
	decoder := yaml.NewDecoder(strings.NewReader(string(data)))
	fileIndex := 0

	for {
		var doc map[string]interface{}
		if err := decoder.Decode(&doc); err != nil {
			if err.Error() == "EOF" {
				break
			}
			return fmt.Errorf("document decode failed: %w", err)
		}

		// Skip empty documents
		if len(doc) == 0 {
			continue
		}

		// Extract metadata for filename
		apiVersion, _ := doc["apiVersion"].(string)
		kind, _ := doc["kind"].(string)

		var name string
		if metadata, ok := doc["metadata"].(map[string]interface{}); ok {
			name, _ = metadata["name"].(string)
		}

		// Generate filename: {apiVersion}_{kind}_{name}.yaml
		// Replace slashes in apiVersion (e.g., apps/v1 -> apps_v1)
		filename := fmt.Sprintf("%s_%s_%s.yaml",
			strings.ReplaceAll(apiVersion, "/", "_"),
			strings.ToLower(kind),
			name,
		)

		// Fallback to index-based naming if we can't extract metadata
		if apiVersion == "" || kind == "" || name == "" {
			filename = fmt.Sprintf("resource_%d.yaml", fileIndex)
		}

		// Marshal document back to YAML
		out, err := yaml.Marshal(doc)
		if err != nil {
			return fmt.Errorf("couldn't marshal document: %w", err)
		}

		// Write to file
		filePath := path.Join(outputDir, filename)
		if err := os.WriteFile(filePath, out, 0644); err != nil {
			return fmt.Errorf("couldn't write file %s: %w", filename, err)
		}

		fileIndex++
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
	err := sanitizeDirectoryFiles(p)
	if err != nil {
		return err
	}
	// cue import yaml -p secrets -f -l 'strings.ToLower(kind)' -l 'metadata.name' -R -i secrets/doppler-operator.yaml
	pkgName := path.Base(pkg)
	args := []string{"import", "yaml", "-p", pkgName, "-f", "-l", "strings.ToLower(kind)", "-l", "metadata.name", "-R", "-i", "-s", "."}
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

// sanitizeDirectoryFiles makes sure every file in the directory has a cue compatible name
func sanitizeDirectoryFiles(p string) error {
	entries, err := os.ReadDir(p)
	if err != nil {
		return err
	}
	var errs error
	for _, e := range entries {
		if e.IsDir() {
			continue
		}
		if changed, newName := sanitizedName(e.Name()); changed {
			err := os.Rename(path.Join(p, e.Name()), path.Join(p, newName))
			if err != nil {
				errs = errors.Join(errs, fmt.Errorf("couldn't sanitize filename: %w", err))
			}
		}
	}
	return errs
}

// sanitizedName returns whether the filename needs to change and what it should change to
func sanitizedName(name string) (bool, string) {
	if strings.Contains(name, ":") {
		return true, strings.ReplaceAll(name, ":", "_")
	}
	return false, name
}
