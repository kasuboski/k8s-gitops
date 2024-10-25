package cloudflare

rolebinding: "cloudflare-leader-election-rolebinding": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/managed-by": "kustomize"
			"app.kubernetes.io/name":       "cloudflare-kubernetes-gateway"
		}
		name:      "cloudflare-leader-election-rolebinding"
		namespace: "cloudflare-gateway"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "cloudflare-leader-election-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cloudflare-controller-manager"
		namespace: "cloudflare-gateway"
	}]
}
