package media

service: radarr: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "radarr"
			"app.kubernetes.io/name": "radarr"
		}
		name: "radarr"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "radarr"
	}
}
