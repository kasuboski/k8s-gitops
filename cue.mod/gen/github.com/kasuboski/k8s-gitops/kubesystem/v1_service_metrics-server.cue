package kubesystem

service: "metrics-server": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: "k8s-app": "metrics-server"
		name:      "metrics-server"
		namespace: "kube-system"
	}
	spec: {
		ports: [{
			name:       "https"
			port:       443
			protocol:   "TCP"
			targetPort: "https"
		}]
		selector: "k8s-app": "metrics-server"
	}
}
