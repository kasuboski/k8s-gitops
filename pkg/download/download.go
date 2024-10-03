package download

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"path/filepath"

	"github.com/hashicorp/go-getter"
	"gopkg.in/yaml.v3"
)

func DownloadSomething(source, dst string) error {
	err := getter.GetFile(dst, source)
	if err != nil {
		return fmt.Errorf("failed downloading %s: %w", source, err)
	}

	if isYaml(source) {
		return canonicalizeYaml(dst)
	}

	return nil
}

func isYaml(source string) bool {
	return filepath.Ext(source) == ".yaml"
}

func canonicalizeYaml(dst string) error {
	f, err := os.Open(dst)
	if err != nil {
		return fmt.Errorf("couldn't open %s: %w", dst, err)
	}
	defer f.Close()

	temp, err := os.CreateTemp("", filepath.Base(dst))
	if err != nil {
		return fmt.Errorf("couldn't create temp file: %w", err)
	}

	r := bufio.NewReader(f)
	w := bufio.NewWriter(temp)

	decoder := yaml.NewDecoder(r)
	encoder := yaml.NewEncoder(w)
	defer encoder.Close()
	for {
		var d map[string]interface{}
		if err := decoder.Decode(&d); err != nil {
			if err == io.EOF {
				break
			}
			return fmt.Errorf("document decode failed: %w", err)
		}

		if len(d) == 0 {
			continue
		}
		err := encoder.Encode(&d)
		if err != nil {
			return fmt.Errorf("couldn't encode document: %w", err)
		}
	}

	err = os.Rename(temp.Name(), dst)
	if err != nil {
		return fmt.Errorf("couldn't move tmp file: %w", err)
	}
	return nil
}
