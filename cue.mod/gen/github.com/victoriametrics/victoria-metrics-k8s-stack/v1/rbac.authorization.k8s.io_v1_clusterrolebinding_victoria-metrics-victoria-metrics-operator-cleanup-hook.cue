package v1

clusterrolebinding: "victoria-metrics-victoria-metrics-operator-cleanup-hook": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		annotations: {
			"helm.sh/hook":               "pre-delete"
			"helm.sh/hook-delete-policy": "before-hook-creation"
			"helm.sh/hook-weight":        "-4"
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
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "victoria-metrics-victoria-metrics-operator-cleanup-hook"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "victoria-metrics-victoria-metrics-operator-cleanup-hook"
		namespace: "victoria-metrics"
	}]
}
