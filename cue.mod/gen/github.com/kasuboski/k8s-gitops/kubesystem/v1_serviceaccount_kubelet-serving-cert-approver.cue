package kubesystem

serviceaccount: "kubelet-serving-cert-approver": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":     "kubelet-serving-cert-approver"
		}
		name:      "kubelet-serving-cert-approver"
		namespace: "kube-system"
	}
}
