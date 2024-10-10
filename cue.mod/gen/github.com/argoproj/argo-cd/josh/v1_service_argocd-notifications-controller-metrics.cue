package josh

service: "argocd-notifications-controller-metrics": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: "app.kubernetes.io/name": "argocd-notifications-controller-metrics"
		name:      "argocd-notifications-controller-metrics"
		namespace: "argocd"
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       9001
			protocol:   "TCP"
			targetPort: 9001
		}]
		selector: "app.kubernetes.io/name": "argocd-notifications-controller"
	}
}
