package metallb

clusterrolebinding: "metallb-system:controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: app: "metallb"
		name: "metallb-system:controller"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "metallb-system:controller"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "controller"
		namespace: "metallb-system"
	}]
}
