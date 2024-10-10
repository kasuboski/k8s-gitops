package josh

serviceaccount: "argocd-dex-server": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "dex-server"
			"app.kubernetes.io/name":      "argocd-dex-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-dex-server"
		namespace: "argocd"
	}
}
