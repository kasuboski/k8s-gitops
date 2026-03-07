package v1

serviceaccount: "kube-apiserver-auth-proxy": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "kube-apiserver-auth-proxy"
		namespace: "tailscale"
	}
}
