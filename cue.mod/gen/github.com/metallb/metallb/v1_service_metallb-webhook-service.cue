package metallb

service: "metallb-webhook-service": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name:      "metallb-webhook-service"
		namespace: "metallb-system"
	}
	spec: {
		ports: [{
			port:       443
			targetPort: 9443
		}]
		selector: component: "controller"
	}
}