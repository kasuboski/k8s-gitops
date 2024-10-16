package josh

serviceaccount: "argocd-notifications-controller": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "notifications-controller"
			"app.kubernetes.io/name":      "argocd-notifications-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-notifications-controller"
		namespace: "argocd"
	}
}