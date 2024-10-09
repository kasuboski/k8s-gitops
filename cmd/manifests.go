package cmd

import (
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
		err := os.MkdirAll("manifests", 0750)
		if err != nil {
			log.Fatalf("failed to create manifests directory: %s", err)
		}
		appsApp, err := manifests.ArgoAppsApp(".")
		if err != nil {
			log.Fatal(err)
		}
		appsAppPath := path.Join("manifests", "apps.json")
		err = manifests.WriteResource(appsAppPath, appsApp)
		if err != nil {
			log.Fatal(err)
		}

		argoApps, err := manifests.ArgoApps(".")
		if err != nil {
			log.Fatal(err)
		}
		appRoot := path.Join("manifests", "apps")
		err = os.RemoveAll(appRoot)
		if err != nil {
			log.Printf("failed to remove app directory: %s", err)
		}
		err = os.MkdirAll(appRoot, 0750)
		if err != nil {
			log.Printf("failed to create app directory: %s", err)
		}
		for _, app := range argoApps {
			metadata := app["metadata"].(map[string]interface{})
			name := metadata["name"]
			p := path.Join(appRoot, fmt.Sprintf("%s.json", name))
			err := manifests.WriteResource(p, app)
			if err != nil {
				log.Println(err)
			}
		}

		res, err := manifests.AppsResources(".")
		if err != nil {
			log.Fatal(err)
		}

		for app, resources := range res {
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
				p := path.Join(appPath, fmt.Sprintf("%s-%s.json", kind, name))
				err := manifests.WriteResource(p, r)
				if err != nil {
					log.Println(err)
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
