package ingress

gateway: http: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "Gateway"
	metadata: name:         "http"
	spec: gatewayClassName: "eg"
	spec: listeners: [{
		name:     "http"
		protocol: "HTTP"
		port:     80
		allowedRoutes: namespaces: from: "ALL"
	}]
}
