package metallb

serviceaccount: speaker: {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: app: "metallb"
		name:      "speaker"
		namespace: "metallb-system"
	}
}
