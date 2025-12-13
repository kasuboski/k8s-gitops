package v1

serviceaccount: "victoria-metrics-kube-state-metrics": {
	apiVersion:                   "v1"
	automountServiceAccountToken: true
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "metrics"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "kube-state-metrics"
			"app.kubernetes.io/part-of":    "kube-state-metrics"
			"app.kubernetes.io/version":    "2.17.0"
			"helm.sh/chart":                "kube-state-metrics-6.4.2"
		}
		name:      "victoria-metrics-kube-state-metrics"
		namespace: "victoria-metrics"
	}
}
