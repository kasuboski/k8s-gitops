package media

service: prowlarr: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "prowlarr"
			"app.kubernetes.io/name": "prowlarr"
		}
		name: "prowlarr"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "prowlarr"
	}
}
