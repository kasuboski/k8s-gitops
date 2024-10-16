package media

service: sabnzbd: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "sabnzbd"
			"app.kubernetes.io/name": "sabnzbd"
		}
		name: "sabnzbd"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "web"
		}]
		selector: "app.kubernetes.io/name": "sabnzbd"
	}
}