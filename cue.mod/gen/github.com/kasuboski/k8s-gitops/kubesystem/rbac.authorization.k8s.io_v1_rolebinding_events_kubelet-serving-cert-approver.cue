package kubesystem

rolebinding: "events:kubelet-serving-cert-approver": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":     "kubelet-serving-cert-approver"
		}
		name:      "events:kubelet-serving-cert-approver"
		namespace: "kube-system"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "events:kubelet-serving-cert-approver"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "kubelet-serving-cert-approver"
		namespace: "kube-system"
	}]
}
