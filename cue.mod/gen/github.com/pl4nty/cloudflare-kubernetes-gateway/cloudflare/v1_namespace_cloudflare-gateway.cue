package cloudflare

namespace: "cloudflare-gateway": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: {
			"app.kubernetes.io/managed-by": "kustomize"
			"app.kubernetes.io/name":       "cloudflare-kubernetes-gateway"
			"control-plane":                "controller-manager"
		}
		name: "cloudflare-gateway"
	}
}
