package v1

serviceaccount: operator: {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "operator"
		namespace: "tailscale"
	}
}
