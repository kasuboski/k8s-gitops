package media

service: overseerr: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "overseerr"
			"app.kubernetes.io/name": "overseerr"
		}
		name: "overseerr"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "overseerr"
	}
}