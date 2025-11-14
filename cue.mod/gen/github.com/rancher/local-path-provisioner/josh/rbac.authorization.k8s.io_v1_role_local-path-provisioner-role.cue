package josh

role: "local-path-provisioner-role": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name:      "local-path-provisioner-role"
		namespace: "local-path-storage"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"patch",
			"update",
			"delete",
		]
	}]
}
