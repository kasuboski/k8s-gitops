package cloudflare_gateway

gatewayclass: eg: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "GatewayClass"
	metadata: name:       "cloudflare"
	spec: controllerName: "github.com/pl4nty/cloudflare-kubernetes-gateway"
  spec: parametersRef: {
		group: ""
    kind: "Secret"
    namespace: "cloudflare-gateway"
    name: "cloudflare"
  }
}

gateway: cloudflare: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "Gateway"
	metadata: name:         "cloudflare"
	spec: gatewayClassName: "cloudflare"
	spec: listeners: [{
		name:     "https"
		protocol: "HTTPS"
		port:     443
		allowedRoutes: namespaces: from: "All"
	}]
}