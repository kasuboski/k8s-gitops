package josh

role: "argocd-notifications-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name:      "argocd-notifications-controller"
		namespace: "argocd"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"applications",
			"appprojects",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"configmaps",
			"secrets",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resourceNames: ["argocd-notifications-cm"]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resourceNames: ["argocd-notifications-secret"]
		resources: ["secrets"]
		verbs: ["get"]
	}]
}
