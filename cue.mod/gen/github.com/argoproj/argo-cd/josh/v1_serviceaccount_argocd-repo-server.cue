package josh

serviceaccount: "argocd-repo-server": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "repo-server"
			"app.kubernetes.io/name":      "argocd-repo-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-repo-server"
		namespace: "argocd"
	}
}
