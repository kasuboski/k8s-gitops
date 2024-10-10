package josh

configmap: "argocd-tls-certs-cm": {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "argocd-tls-certs-cm"
			"app.kubernetes.io/part-of": "argocd"
		}
		name:      "argocd-tls-certs-cm"
		namespace: "argocd"
	}
}
