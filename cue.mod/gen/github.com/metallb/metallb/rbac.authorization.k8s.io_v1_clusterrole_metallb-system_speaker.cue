package metallb

clusterrole: "metallb-system:speaker": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: app: "metallb"
		name: "metallb-system:speaker"
	}
	rules: [{
		apiGroups: ["metallb.io"]
		resources: [
			"servicel2statuses",
			"servicel2statuses/status",
		]
		verbs: ["*"]
	}, {
		apiGroups: [""]
		resources: [
			"services",
			"endpoints",
			"nodes",
			"namespaces",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: ["policy"]
		resourceNames: ["speaker"]
		resources: ["podsecuritypolicies"]
		verbs: ["use"]
	}]
}
