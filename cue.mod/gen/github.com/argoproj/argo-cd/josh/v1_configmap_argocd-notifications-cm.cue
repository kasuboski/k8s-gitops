package josh

configmap: "argocd-notifications-cm": {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		name:      "argocd-notifications-cm"
		namespace: "argocd"
	}
}
