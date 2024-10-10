package cmd

import (
	"context"
	"log"

	"github.com/kasuboski/k8s-gitops/pkg/download"
	"github.com/spf13/cobra"
)

// vendorCmd represents the vendor command
var vendorCmd = &cobra.Command{
	Use:   "vendor",
	Short: "vendor sources from vendor.cue",
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()
		vs, err := download.LoadVendor(".")
		if err != nil {
			log.Fatal(err)
		}
		if err := download.DoVendor(ctx, vs); err != nil {
			log.Fatal(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(vendorCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// vendorCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// vendorCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
