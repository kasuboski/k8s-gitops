package josh

configmap: "argocd-cmd-params-cm": {
	apiVersion: "v1"
	data: "server.insecure": "true"
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "argocd-cmd-params-cm"
			"app.kubernetes.io/part-of": "argocd"
		}
		name:      "argocd-cmd-params-cm"
		namespace: "argocd"
	}
}
