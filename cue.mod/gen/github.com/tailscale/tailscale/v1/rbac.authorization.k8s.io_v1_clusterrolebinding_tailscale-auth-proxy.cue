package v1

clusterrolebinding: "tailscale-auth-proxy": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "tailscale-auth-proxy"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "tailscale-auth-proxy"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "operator"
		namespace: "tailscale"
	}, {
		kind:      "ServiceAccount"
		name:      "kube-apiserver-auth-proxy"
		namespace: "tailscale"
	}]
}
