package v1

rolebinding: "victoria-metrics-grafana": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
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
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "victoria-metrics-grafana"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "victoria-metrics-grafana"
		namespace: "victoria-metrics"
	}]
}
