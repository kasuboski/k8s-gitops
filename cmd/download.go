package cmd

import (
	"log"

	"github.com/kasuboski/k8s-gitops/pkg/download"
	"github.com/spf13/cobra"
)

// downloadCmd represents the download command
var downloadCmd = &cobra.Command{
	Use:   "download",
	Args:  cobra.ExactArgs(2),
	Short: "Download something using the go-getter format",
	Run: func(cmd *cobra.Command, args []string) {
		source, destination := args[0], args[1]
		err := download.DownloadSomething(source, destination)
		if err != nil {
			log.Fatal(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(downloadCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// downloadCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// downloadCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
