package v1

serviceaccount: proxies: {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "proxies"
		namespace: "tailscale"
	}
}
