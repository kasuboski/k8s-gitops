package v1

clusterrole: "victoria-metrics-victoria-metrics-operator-cleanup-hook": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		annotations: {
			"helm.sh/hook":               "pre-delete"
			"helm.sh/hook-delete-policy": "before-hook-creation"
			"helm.sh/hook-weight":        "-5"
		}
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "victoria-metrics-victoria-metrics-operator-cleanup-hook"
		namespace: "victoria-metrics"
	}
	rules: [{
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
