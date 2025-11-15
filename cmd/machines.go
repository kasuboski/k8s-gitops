package cmd

import (
	"context"
	"fmt"
	"log"

	"github.com/kasuboski/k8s-gitops/pkg/machine"
	"github.com/spf13/cobra"
)

var machinesCmd = &cobra.Command{
	Use:   "machines",
	Short: "Generate Talos machine configurations from CUE",
	Long: `Generate Talos machine configurations from CUE definitions.

This command:
1. Reads node definitions from machines.cue
2. Generates base configs with talosctl gen config
3. Applies CUE-defined patches using talosctl machineconfig patch
4. Outputs complete configs ready for talosctl apply-config

Example:
  k8s gen machines`,
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()

		clusterName := "pi"
		endpoint := "https://192.168.86.19:6443"
		secretsFile := "talos/result/secrets.yaml"
		outputDir := "talos/result"

		if err := machine.GenerateConfigsFromCUE(ctx, clusterName, endpoint, secretsFile, outputDir); err != nil {
			log.Fatalf("Failed to generate configs: %v", err)
		}

		fmt.Println("\nMachine configs generated successfully!")
		fmt.Println("Apply with: talosctl apply-config -n <node> -f talos/result/<node>.yaml")
	},
}

func init() {
	generateCmd.AddCommand(machinesCmd)
}
