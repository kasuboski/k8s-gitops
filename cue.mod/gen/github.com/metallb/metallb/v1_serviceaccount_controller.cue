package metallb

serviceaccount: controller: {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: app: "metallb"
		name:      "controller"
		namespace: "metallb-system"
	}
}
