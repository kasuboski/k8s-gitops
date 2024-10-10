package josh

rolebinding: "argocd-notifications-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
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
