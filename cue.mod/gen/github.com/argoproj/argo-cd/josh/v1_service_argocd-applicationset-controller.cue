package josh

service: "argocd-applicationset-controller": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd-applicationset"
		}
		name:      "argocd-applicationset-controller"
		namespace: "argocd"
	}
	spec: {
		ports: [{
			name:       "webhook"
			port:       7000
			protocol:   "TCP"
			targetPort: "webhook"
		}, {
			name:       "metrics"
			port:       8080
			protocol:   "TCP"
			targetPort: "metrics"
		}]
		selector: "app.kubernetes.io/name": "argocd-applicationset-controller"
	}
}
