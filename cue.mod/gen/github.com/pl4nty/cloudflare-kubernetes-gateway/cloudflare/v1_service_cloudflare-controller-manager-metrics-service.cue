package cloudflare

service: "cloudflare-controller-manager-metrics-service": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/managed-by": "kustomize"
			"app.kubernetes.io/name":       "cloudflare-kubernetes-gateway"
			"control-plane":                "controller-manager"
		}
		name:      "cloudflare-controller-manager-metrics-service"
		namespace: "cloudflare-gateway"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       8080
			protocol:   "TCP"
			targetPort: 8080
		}]
		selector: "control-plane": "controller-manager"
	}
}
