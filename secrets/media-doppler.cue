package secrets

dopplersecret: media: {
	apiVersion: "secrets.doppler.com/v1alpha1"
	kind:       "DopplerSecret"
	metadata: {
		name:      "media"
		namespace: "doppler-operator-system"
	}
	spec: {
		tokenSecret: name: "media-token"
		managedSecret: {
			name:      "media-secret"
			namespace: "media"
		}
	}
}
