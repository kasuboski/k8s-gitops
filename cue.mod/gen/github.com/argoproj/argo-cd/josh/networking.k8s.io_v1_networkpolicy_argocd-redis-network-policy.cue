package josh

networkpolicy: "argocd-redis-network-policy": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "argocd-redis-network-policy"
		namespace: "argocd"
	}
	spec: {
		egress: [{
			ports: [{
				port:     53
				protocol: "UDP"
			}, {
				port:     53
				protocol: "TCP"
			}]
		}]
		ingress: [{
			from: [{
				podSelector: matchLabels: "app.kubernetes.io/name": "argocd-server"
			}, {
				podSelector: matchLabels: "app.kubernetes.io/name": "argocd-repo-server"
			}, {
				podSelector: matchLabels: "app.kubernetes.io/name": "argocd-application-controller"
			}]
			ports: [{
				port:     6379
				protocol: "TCP"
			}]
		}]
		podSelector: matchLabels: "app.kubernetes.io/name": "argocd-redis"
		policyTypes: [
			"Ingress",
			"Egress",
		]
	}
}
