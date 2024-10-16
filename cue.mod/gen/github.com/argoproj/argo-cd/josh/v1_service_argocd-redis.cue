package josh

service: "argocd-redis": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "redis"
			"app.kubernetes.io/name":      "argocd-redis"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-redis"
		namespace: "argocd"
	}
	spec: {
		ports: [{
			name:       "tcp-redis"
			port:       6379
			targetPort: 6379
		}]
		selector: "app.kubernetes.io/name": "argocd-redis"
	}
}