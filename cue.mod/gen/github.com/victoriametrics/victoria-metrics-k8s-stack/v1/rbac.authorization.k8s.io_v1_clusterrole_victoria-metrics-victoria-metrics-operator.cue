package v1

clusterrole: "victoria-metrics-victoria-metrics-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name: "victoria-metrics-victoria-metrics-operator"
	}
	rules: [{
		nonResourceURLs: [
			"/metrics",
			"/metrics/resources",
		]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: [
			"configmaps",
			"configmaps/finalizers",
			"endpoints",
			"events",
			"persistentvolumeclaims",
			"persistentvolumeclaims/finalizers",
			"pods",
			"pods/eviction",
			"secrets",
			"secrets/finalizers",
			"services",
			"services/finalizers",
			"serviceaccounts",
			"serviceaccounts/finalizers",
		]
		verbs: ["*"]
	}, {
		apiGroups: [""]
		resources: [
			"configmaps/status",
			"nodes",
			"nodes/proxy",
			"nodes/metrics",
			"namespaces",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["apps"]
		resources: [
			"daemonsets",
			"daemonsets/finalizers",
			"deployments",
			"deployments/finalizers",
			"replicasets",
			"statefulsets",
			"statefulsets/finalizers",
			"statefulsets/status",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: [
			"clusterrolebindings",
			"clusterrolebindings/finalizers",
			"clusterroles",
			"clusterroles/finalizers",
			"roles",
			"rolebindings",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["storage.k8s.io"]
		resources: ["storageclasses"]
		verbs: [
			"list",
			"get",
			"watch",
		]
	}, {
		apiGroups: ["policy"]
		resources: [
			"poddisruptionbudgets",
			"poddisruptionbudgets/finalizers",
		]
		verbs: ["*"]
	}, {
		apiGroups: [
			"route.openshift.io",
			"image.openshift.io",
		]
		resources: [
			"routers/metrics",
			"registry/metrics",
		]
		verbs: ["get"]
	}, {
		apiGroups: ["autoscaling"]
		resources: ["horizontalpodautoscalers"]
		verbs: ["*"]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: [
			"ingresses",
			"ingresses/finalizers",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: [
			"get",
			"list",
		]
	}, {
		apiGroups: ["discovery.k8s.io"]
		resources: ["endpointslices"]
		verbs: [
			"list",
			"watch",
			"get",
		]
	}, {
		apiGroups: ["operator.victoriametrics.com"]
		resources: [
			"vlagents",
			"vlagents/finalizers",
			"vlagents/status",
			"vlclusters",
			"vlclusters/finalizers",
			"vlclusters/status",
			"vlogs",
			"vlogs/finalizers",
			"vlogs/status",
			"vlsingles",
			"vlsingles/finalizers",
			"vlsingles/status",
			"vmagents",
			"vmagents/finalizers",
			"vmagents/status",
			"vmalertmanagerconfigs",
			"vmalertmanagerconfigs/finalizers",
			"vmalertmanagerconfigs/status",
			"vmalertmanagers",
			"vmalertmanagers/finalizers",
			"vmalertmanagers/status",
			"vmalerts",
			"vmalerts/finalizers",
			"vmalerts/status",
			"vmanomalies",
			"vmanomalies/finalizers",
			"vmanomalies/status",
			"vmauths",
			"vmauths/finalizers",
			"vmauths/status",
			"vmclusters",
			"vmclusters/finalizers",
			"vmclusters/status",
			"vmnodescrapes",
			"vmnodescrapes/finalizers",
			"vmnodescrapes/status",
			"vmpodscrapes",
			"vmpodscrapes/finalizers",
			"vmpodscrapes/status",
			"vmprobes",
			"vmprobes/finalizers",
			"vmprobes/status",
			"vmrules",
			"vmrules/finalizers",
			"vmrules/status",
			"vmscrapeconfigs",
			"vmscrapeconfigs/finalizers",
			"vmscrapeconfigs/status",
			"vmservicescrapes",
			"vmservicescrapes/finalizers",
			"vmservicescrapes/status",
			"vmsingles",
			"vmsingles/finalizers",
			"vmsingles/status",
			"vmstaticscrapes",
			"vmstaticscrapes/finalizers",
			"vmstaticscrapes/status",
			"vmusers",
			"vmusers/finalizers",
			"vmusers/status",
			"vtclusters",
			"vtclusters/finalizers",
			"vtclusters/status",
			"vtsingles",
			"vtsingles/finalizers",
			"vtsingles/status",
		]
		verbs: ["*"]
	}]
}
