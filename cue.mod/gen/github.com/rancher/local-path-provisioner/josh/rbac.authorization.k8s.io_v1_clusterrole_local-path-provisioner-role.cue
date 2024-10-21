package josh

clusterrole: "local-path-provisioner-role": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "local-path-provisioner-role"
	rules: [{
		apiGroups: [""]
		resources: [
			"nodes",
			"persistentvolumeclaims",
			"configmaps",
			"pods",
			"pods/log",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"patch",
			"update",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
