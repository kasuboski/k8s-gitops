package v1

clusterrole: "tailscale-auth-proxy": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "tailscale-auth-proxy"
	rules: [{
		apiGroups: [""]
		resources: [
			"users",
			"groups",
		]
		verbs: ["impersonate"]
	}]
}
