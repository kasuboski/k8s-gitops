package v1

rolebinding: proxies: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name:      "proxies"
		namespace: "tailscale"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "proxies"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "proxies"
		namespace: "tailscale"
	}]
}
