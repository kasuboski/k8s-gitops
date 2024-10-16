package josh

role: "argocd-notifications-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "notifications-controller"
			"app.kubernetes.io/name":      "argocd-notifications-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
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
