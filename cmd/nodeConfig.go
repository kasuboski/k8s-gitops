package cmd

import (
	"context"
	"log"

	"github.com/kasuboski/k8s-gitops/pkg/machine"
	"github.com/spf13/cobra"
)

// nodeConfigCmd represents the nodeConfig command
var nodeConfigCmd = &cobra.Command{
	Aliases: []string{"nc"},
	Use:     "nodeConfig nodeName",
	Args:    cobra.ExactArgs(1),
	Short:   "generate the node config for a talos node",
	Run: func(cmd *cobra.Command, args []string) {
		nodeName := args[0]
		// this probably only works from the talos root
		clusterConfig, err := machine.ReadClusterConfig("./cluster.yaml")
		if err != nil {
			log.Fatal(err)
		}

		tc, err := machine.TalosConfigInfoFromClusterConfig(machine.DefaultNodePatches(), clusterConfig, nodeName)
		if err != nil {
			log.Fatal(err)
		}
		ctx, cancel := context.WithCancel(context.Background())
		defer cancel()
		err = machine.GenerateMachineConfig(ctx, *tc)
		if err != nil {
			log.Fatal(err)
		}

		err = machine.ValidateMachineConfig(ctx, tc.OutputFilePath, "metal")
		if err != nil {
			log.Fatal(err)
		}
	},
}

func init() {
	generateCmd.AddCommand(nodeConfigCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// nodeConfigCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// nodeConfigCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
