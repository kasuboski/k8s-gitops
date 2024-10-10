package josh

service: "argocd-server-metrics": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "server"
			"app.kubernetes.io/name":      "argocd-server-metrics"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-server-metrics"
		namespace: "argocd"
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       8083
			protocol:   "TCP"
			targetPort: 8083
		}]
		selector: "app.kubernetes.io/name": "argocd-server"
	}
}
