package media

service: lidarr: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "lidarr"
			"app.kubernetes.io/name": "lidarr"
		}
		name: "lidarr"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
		selector: "app.kubernetes.io/name": "lidarr"
	}
}
