package machines

// Cluster-level configuration - single source of truth
cluster: {
	name:     "joshcorp"
	endpoint: "https://k8s-api.joshcorp.co:6443"

	// Talos version and Image Factory schematics
	talos: {
		version: "v1.11.5"
		schematics: {
			// x86_64 with Intel extensions and iSCSI tools
			x86: "249d9135de54962744e917cfe654117000cba369f9152fbab9d055a00aa3664f"
			// Raspberry Pi with custom extensions
			rpi: "f8a903f101ce10f686476024898734bb6b36353cc4d41f348514db9004ec0a9d"
		}
	}

	// Node network configuration
	nodeEndpoints: {
		adel:      "192.168.86.120"
		cherry:    "192.168.86.39"
		blueberry: "192.168.86.38"
		pumpkin:   "192.168.86.30"
		apple:     "192.168.86.29"
		elsa:      "192.168.86.50"
	}

	// Talosconfig defaults - which nodes to use as endpoints
	talosEndpoints: [
		nodeEndpoints.adel, // Control plane is primary endpoint
	]
}
