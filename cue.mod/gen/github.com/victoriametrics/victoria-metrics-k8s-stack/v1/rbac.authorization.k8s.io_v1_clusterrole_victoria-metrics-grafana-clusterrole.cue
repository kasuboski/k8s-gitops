package v1

clusterrole: "victoria-metrics-grafana-clusterrole": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name: "victoria-metrics-grafana-clusterrole"
	}
	rules: [{
		apiGroups: [""]
		resources: [
			"configmaps",
			"secrets",
		]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}]
}
