package apps

import "github.com/argoproj/argo-cd/josh"

apps: argocd: {
	namespace: "argocd"
	resources: josh & _local
}

_local: httproute: argocdserver: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRoute"
	metadata: name:      "argocd-server"
	metadata: namespace: "argocd"
	spec: {
		parentRefs: [
			{
				group:     "gateway.networking.k8s.io"
				kind:      "Gateway"
				name:      "http"
				namespace: "envoy-gateway-system"
			},
		]
		hostnames: [
			"argocd.joshcorp.co",
		]
		rules: [
			{
				backendRefs: [
					{
						group:  ""
						kind:   "Service"
						name:   "argocd-server"
						port:   80
						weight: 1
					},
				]
				matches: [
					{
						path: {
							type:  "PathPrefix"
							value: "/"
						}
					},
				]
			},
		]
	}
}
