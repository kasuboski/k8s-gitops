package v1

serviceaccount: "victoria-metrics-grafana": {
	apiVersion:                   "v1"
	automountServiceAccountToken: false
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name:      "victoria-metrics-grafana"
		namespace: "victoria-metrics"
	}
}
