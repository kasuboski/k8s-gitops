package kubesystem

clusterrole: "system:aggregated-metrics-reader": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"k8s-app":                                      "metrics-server"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
			"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
			"rbac.authorization.k8s.io/aggregate-to-view":  "true"
		}
		name: "system:aggregated-metrics-reader"
	}
	rules: [{
		apiGroups: ["metrics.k8s.io"]
		resources: [
			"pods",
			"nodes",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
