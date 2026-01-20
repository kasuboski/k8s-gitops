package secrets

dopplersecret: "opencode": {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "opencode"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "opencode-token"
		managedSecret: {
			name:      "opencode"
			namespace: "opencode"
		}
	}
}
