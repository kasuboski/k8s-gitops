package josh

role: "argocd-applicationset-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "applicationset-controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-applicationset-controller"
		namespace: "argocd"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"applications",
			"applicationsets",
			"applicationsets/finalizers",
		]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: ["appprojects"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: ["applicationsets/status"]
		verbs: [
			"get",
			"patch",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"get",
			"list",
			"patch",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"secrets",
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"apps",
			"extensions",
		]
		resources: ["deployments"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
