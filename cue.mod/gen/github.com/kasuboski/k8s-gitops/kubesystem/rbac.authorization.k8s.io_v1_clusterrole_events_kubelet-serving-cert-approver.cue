package kubesystem

clusterrole: "events:kubelet-serving-cert-approver": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":     "kubelet-serving-cert-approver"
		}
		name: "events:kubelet-serving-cert-approver"
	}
	rules: [{
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}
