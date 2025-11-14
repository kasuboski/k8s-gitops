package descheduler

clusterrole: "descheduler-cluster-role": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "descheduler-cluster-role"
	rules: [{
		apiGroups: ["events.k8s.io"]
		resources: ["events"]
		verbs: [
			"create",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"watch",
			"list",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/eviction"]
		verbs: ["create"]
	}, {
		apiGroups: ["scheduling.k8s.io"]
		resources: ["priorityclasses"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resourceNames: ["descheduler"]
		resources: ["leases"]
		verbs: [
			"get",
			"patch",
			"delete",
		]
	}]
}
