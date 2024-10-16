package metallb

rolebinding: "pod-lister": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: app: "metallb"
		name:      "pod-lister"
		namespace: "metallb-system"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "pod-lister"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "speaker"
		namespace: "metallb-system"
	}]
}