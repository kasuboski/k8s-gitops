package josh

clusterrolebinding: "local-path-provisioner-bind": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "local-path-provisioner-bind"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "local-path-provisioner-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "local-path-provisioner-service-account"
		namespace: "local-path-storage"
	}]
}
