package machines

// Cluster-level configuration - single source of truth
cluster: {
	name:     "joshcorp"
	endpoint: "https://k8s-api.joshcorp.co:6443"

	// Node network configuration
	nodeEndpoints: {
		adel:      "192.168.86.120"
		cherry:    "192.168.86.121"
		blueberry: "192.168.86.122"
		pumpkin:   "192.168.86.123"
		apple:     "192.168.86.124"
	}

	// Talosconfig defaults - which nodes to use as endpoints
	talosEndpoints: [
		nodeEndpoints.adel, // Control plane is primary endpoint
	]
}
