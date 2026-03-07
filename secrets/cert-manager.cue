package secrets

dopplersecret: "cert-manager": {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "cert-manager"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "cert-manager-token"
		managedSecret: {
			name:      "cert-manager"
			namespace: "cert-manager"
		}
	}
}
