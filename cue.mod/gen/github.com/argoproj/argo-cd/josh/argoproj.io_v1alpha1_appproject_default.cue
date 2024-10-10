package josh

appproject: default: {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "AppProject"
	metadata: {
		name:      "default"
		namespace: "argocd"
	}
	spec: {
		clusterResourceWhitelist: [{
			group: "*"
			kind:  "*"
		}]
		description: "The default project for everything"
		destinations: [{
			namespace: "*"
			server:    "https://kubernetes.default.svc"
		}]
		namespaceResourceBlacklist: [{
			group: ""
			kind:  "ResourceQuota"
		}, {
			group: ""
			kind:  "LimitRange"
		}, {
			group: ""
			kind:  "NetworkPolicy"
		}]
		sourceRepos: ["https://github.com/kasuboski/k8s-gitops.git"]
	}
}
