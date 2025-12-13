package v1

clusterrolebinding: "victoria-metrics-victoria-metrics-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name: "victoria-metrics-victoria-metrics-operator"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "victoria-metrics-victoria-metrics-operator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "victoria-metrics-victoria-metrics-operator"
		namespace: "victoria-metrics"
	}]
}
