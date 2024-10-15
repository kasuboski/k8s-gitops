package kubesystem

namespace: "kube-system": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":         "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":             "kubelet-serving-cert-approver"
			"pod-security.kubernetes.io/audit":   "restricted"
			"pod-security.kubernetes.io/enforce": "restricted"
			"pod-security.kubernetes.io/warn":    "restricted"
		}
		name: "kube-system"
	}
}
