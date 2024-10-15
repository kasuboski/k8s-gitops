package metallb

secret: "metallb-webhook-cert": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		name:      "metallb-webhook-cert"
		namespace: "metallb-system"
	}
}
