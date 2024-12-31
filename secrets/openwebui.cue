package secrets

dopplersecret: "openwebui": {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "openwebui"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "openwebui-token"
		managedSecret: {
			name:      "openwebui"
			namespace: "openwebui"
		}
	}
}
