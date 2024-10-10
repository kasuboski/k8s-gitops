package josh

secret: "argocd-notifications-secret": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		name:      "argocd-notifications-secret"
		namespace: "argocd"
	}
	type: "Opaque"
}
