package media

service: sonarr: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "sonarr"
			"app.kubernetes.io/name": "sonarr"
		}
		name: "sonarr"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "sonarr"
	}
}