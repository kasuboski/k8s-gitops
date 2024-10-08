package cmd

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"path"
	"strings"

	"github.com/kasuboski/k8s-gitops/pkg/manifests"
	"github.com/spf13/cobra"
)

// manifestsCmd represents the manifests command
var manifestsCmd = &cobra.Command{
	Use:   "manifests",
	Short: "Generate manifests from the repo",
	Run: func(cmd *cobra.Command, args []string) {
		b, err := manifests.AppsResources(".")
		if err != nil {
			log.Fatal(err)
		}

		for app, resources := range b {
			appPath := path.Join("manifests", app)
			err := os.RemoveAll(appPath)
			if err != nil {
				log.Printf("failed to remove app directory: %s", err)
			}
			err = os.MkdirAll(appPath, 0750)
			if err != nil {
				log.Printf("failed to create app directory: %s", err)
			}
			for _, r := range resources {
				metadata := r["metadata"].(map[string]interface{})
				name := metadata["name"]
				kind := strings.ToLower(r["kind"].(string))
				f, err := os.Create(path.Join(appPath, fmt.Sprintf("%s-%s.json", kind, name)))
				if err != nil {
					log.Printf("failed to create file: %s", err)
				}
				defer f.Close()
				encoder := json.NewEncoder(f)
				encoder.SetIndent("", "  ")
				err = encoder.Encode(r)
				if err != nil {
					log.Printf("failed to write file for %s", name)
				}
			}
		}
	},
}

func init() {
	generateCmd.AddCommand(manifestsCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// manifestsCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// manifestsCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
