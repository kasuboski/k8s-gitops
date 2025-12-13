package v1

serviceaccount: "victoria-metrics-prometheus-node-exporter": {
	apiVersion:                   "v1"
	automountServiceAccountToken: false
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "metrics"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "prometheus-node-exporter"
			"app.kubernetes.io/part-of":    "prometheus-node-exporter"
			"app.kubernetes.io/version":    "1.10.2"
			"helm.sh/chart":                "prometheus-node-exporter-4.49.2"
		}
		name:      "victoria-metrics-prometheus-node-exporter"
		namespace: "victoria-metrics"
	}
}
