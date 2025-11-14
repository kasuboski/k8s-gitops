package cloudflare

serviceaccount: "cloudflare-controller-manager": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/managed-by": "kustomize"
			"app.kubernetes.io/name":       "cloudflare-kubernetes-gateway"
		}
		name:      "cloudflare-controller-manager"
		namespace: "cloudflare-gateway"
	}
}
