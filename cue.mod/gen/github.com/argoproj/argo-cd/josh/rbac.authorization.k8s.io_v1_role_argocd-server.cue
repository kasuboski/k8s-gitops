package josh

role: "argocd-server": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "server"
			"app.kubernetes.io/name":      "argocd-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-server"
		namespace: "argocd"
	}
	rules: [{
		apiGroups: [""]
		resources: [
			"secrets",
			"configmaps",
		]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"applications",
			"appprojects",
			"applicationsets",
		]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"delete",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"list",
		]
	}]
}
