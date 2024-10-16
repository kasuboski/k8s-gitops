package josh

networkpolicy: "argocd-server-network-policy": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "argocd-server-network-policy"
		namespace: "argocd"
	}
	spec: {
		ingress: [{}]
		podSelector: matchLabels: "app.kubernetes.io/name": "argocd-server"
		policyTypes: ["Ingress"]
	}
}