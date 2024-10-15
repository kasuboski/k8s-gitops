package kubesystem

clusterrole: "system:metrics-server": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: "k8s-app": "metrics-server"
		name: "system:metrics-server"
	}
	rules: [{
		apiGroups: [""]
		resources: ["nodes/metrics"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
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
