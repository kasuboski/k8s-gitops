package josh

serviceaccount: "local-path-provisioner-service-account": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "local-path-provisioner-service-account"
		namespace: "local-path-storage"
	}
}
