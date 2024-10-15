package kubesystem

clusterrolebinding: "metrics-server:system:auth-delegator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: "k8s-app": "metrics-server"
		name: "metrics-server:system:auth-delegator"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "system:auth-delegator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "metrics-server"
		namespace: "kube-system"
	}]
}
