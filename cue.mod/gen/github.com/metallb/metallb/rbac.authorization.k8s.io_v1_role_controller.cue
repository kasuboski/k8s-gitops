package metallb

role: controller: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: app: "metallb"
		name:      "controller"
		namespace: "metallb-system"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [""]
		resourceNames: ["memberlist"]
		resources: ["secrets"]
		verbs: ["list"]
	}, {
		apiGroups: ["apps"]
		resourceNames: ["controller"]
		resources: ["deployments"]
		verbs: ["get"]
	}, {
		apiGroups: ["metallb.io"]
		resources: ["bgppeers"]
		verbs: [
			"get",
			"list",
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
		resources: ["ipaddresspools"]
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
		resources: ["l2advertisements"]
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
