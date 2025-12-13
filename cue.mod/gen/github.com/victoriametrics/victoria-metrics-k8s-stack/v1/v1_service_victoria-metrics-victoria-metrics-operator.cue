package v1

service: "victoria-metrics-victoria-metrics-operator": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "victoria-metrics-victoria-metrics-operator"
		namespace: "victoria-metrics"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       8080
			protocol:   "TCP"
			targetPort: "http"
		}, {
			name:       "webhook"
			port:       9443
			targetPort: "webhook"
		}]
		selector: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "victoria-metrics-operator"
		}
		type: "ClusterIP"
	}
}
