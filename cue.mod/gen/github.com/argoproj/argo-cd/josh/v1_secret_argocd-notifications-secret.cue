package josh

secret: "argocd-notifications-secret": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "notifications-controller"
			"app.kubernetes.io/name":      "argocd-notifications-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-notifications-secret"
		namespace: "argocd"
	}
	type: "Opaque"
}
