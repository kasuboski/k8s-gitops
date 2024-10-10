package josh

service: "argocd-metrics": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "metrics"
			"app.kubernetes.io/name":      "argocd-metrics"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-metrics"
		namespace: "argocd"
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       8082
			protocol:   "TCP"
			targetPort: 8082
		}]
		selector: "app.kubernetes.io/name": "argocd-application-controller"
	}
}
