package josh

clusterrolebinding: "argocd-applicationset-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "applicationset-controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name: "argocd-applicationset-controller"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argocd-applicationset-controller"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argocd-applicationset-controller"
		namespace: "argocd"
	}]
}
