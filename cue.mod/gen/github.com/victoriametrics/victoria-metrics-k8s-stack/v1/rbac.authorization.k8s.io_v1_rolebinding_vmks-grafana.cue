package v1

rolebinding: "vmks-grafana": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "vmks"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name:      "vmks-grafana"
		namespace: "victoria-metrics"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "vmks-grafana"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "vmks-grafana"
		namespace: "victoria-metrics"
	}]
}
