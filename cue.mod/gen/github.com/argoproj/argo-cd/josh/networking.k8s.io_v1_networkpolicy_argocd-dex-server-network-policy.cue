package josh

networkpolicy: "argocd-dex-server-network-policy": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "argocd-dex-server-network-policy"
		namespace: "argocd"
	}
	spec: {
		ingress: [{
			from: [{
				podSelector: matchLabels: "app.kubernetes.io/name": "argocd-server"
			}]
			ports: [{
				port:     5556
				protocol: "TCP"
			}, {
				port:     5557
				protocol: "TCP"
			}]
		}, {
			from: [{namespaceSelector: {}}]
			ports: [{
				port:     5558
				protocol: "TCP"
			}]
		}]
		podSelector: matchLabels: "app.kubernetes.io/name": "argocd-dex-server"
		policyTypes: ["Ingress"]
	}
}
