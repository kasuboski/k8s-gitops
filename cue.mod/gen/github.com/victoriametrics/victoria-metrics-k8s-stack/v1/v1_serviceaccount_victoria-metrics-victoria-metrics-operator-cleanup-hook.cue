package v1

serviceaccount: "victoria-metrics-victoria-metrics-operator-cleanup-hook": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		annotations: {
			"helm.sh/hook":               "pre-delete"
			"helm.sh/hook-delete-policy": "before-hook-creation"
			"helm.sh/hook-weight":        "-5"
		}
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "victoria-metrics-victoria-metrics-operator-cleanup-hook"
		namespace: "victoria-metrics"
	}
}
