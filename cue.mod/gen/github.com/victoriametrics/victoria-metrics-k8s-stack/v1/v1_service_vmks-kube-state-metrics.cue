package v1

service: "vmks-kube-state-metrics": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		annotations: "prometheus.io/scrape": "true"
		labels: {
			"app.kubernetes.io/component":  "metrics"
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "kube-state-metrics"
			"app.kubernetes.io/part-of":    "kube-state-metrics"
			"app.kubernetes.io/version":    "2.17.0"
			"helm.sh/chart":                "kube-state-metrics-6.4.2"
		}
		name:      "vmks-kube-state-metrics"
		namespace: "victoria-metrics"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       8080
			protocol:   "TCP"
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/instance": "vmks"
			"app.kubernetes.io/name":     "kube-state-metrics"
		}
		type: "ClusterIP"
	}
}
