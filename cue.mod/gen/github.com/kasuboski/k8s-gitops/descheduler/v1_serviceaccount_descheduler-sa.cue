package descheduler

serviceaccount: "descheduler-sa": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "descheduler-sa"
		namespace: "kube-system"
	}
}
