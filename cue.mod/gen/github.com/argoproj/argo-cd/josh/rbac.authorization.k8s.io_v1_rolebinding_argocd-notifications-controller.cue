package josh

rolebinding: "argocd-notifications-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "notifications-controller"
			"app.kubernetes.io/name":      "argocd-notifications-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-notifications-controller"
		namespace: "argocd"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "argocd-notifications-controller"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argocd-notifications-controller"
		namespace: "argocd"
	}]
}
