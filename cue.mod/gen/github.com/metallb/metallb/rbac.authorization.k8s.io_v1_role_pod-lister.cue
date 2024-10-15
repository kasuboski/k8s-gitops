package metallb

role: "pod-lister": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: app: "metallb"
		name:      "pod-lister"
		namespace: "metallb-system"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"list",
			"get",
		]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["bfdprofiles"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["bgppeers"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["l2advertisements"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["bgpadvertisements"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["ipaddresspools"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["communities"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
