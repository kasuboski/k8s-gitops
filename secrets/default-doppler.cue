package secrets

dopplersecret: default: {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "default"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "default-token"
		managedSecret: {
			name:      "default-secret"
			namespace: "default"
		}
	}
}
