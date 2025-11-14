package josh

serviceaccount: "argocd-applicationset-controller": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "applicationset-controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-applicationset-controller"
		namespace: "argocd"
	}
}
