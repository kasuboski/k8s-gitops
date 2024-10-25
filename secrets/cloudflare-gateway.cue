package secrets

dopplersecret: "cloudflare-gateway": {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "cloudflare-gateway"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "cloudflare-gateway-token"
		managedSecret: {
			name:      "cloudflare"
			namespace: "cloudflare-gateway"
		}
	}
}
