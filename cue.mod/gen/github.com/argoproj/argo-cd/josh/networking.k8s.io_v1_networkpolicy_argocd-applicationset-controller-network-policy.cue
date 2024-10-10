package josh

networkpolicy: "argocd-applicationset-controller-network-policy": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "argocd-applicationset-controller-network-policy"
		namespace: "argocd"
	}
	spec: {
		ingress: [{
			from: [{namespaceSelector: {}}]
			ports: [{
				port:     7000
				protocol: "TCP"
			}, {
				port:     8080
				protocol: "TCP"
			}]
		}]
		podSelector: matchLabels: "app.kubernetes.io/name": "argocd-applicationset-controller"
		policyTypes: ["Ingress"]
	}
}
