package secrets

dopplersecret: "tailscale": {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "tailscale"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "tailscale-token"
		managedSecret: {
			name:      "operator-oauth"
			namespace: "tailscale"
		}
	}
}
