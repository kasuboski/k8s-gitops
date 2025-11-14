package josh

configmap: "argocd-gpg-keys-cm": {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "argocd-gpg-keys-cm"
			"app.kubernetes.io/part-of": "argocd"
		}
		name:      "argocd-gpg-keys-cm"
		namespace: "argocd"
	}
}
