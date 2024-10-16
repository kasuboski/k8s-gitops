package josh

role: "argocd-redis": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "redis"
			"app.kubernetes.io/name":      "argocd-redis"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-redis"
		namespace: "argocd"
	}
	rules: [{
		apiGroups: [""]
		resourceNames: ["argocd-redis"]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["create"]
	}]
}