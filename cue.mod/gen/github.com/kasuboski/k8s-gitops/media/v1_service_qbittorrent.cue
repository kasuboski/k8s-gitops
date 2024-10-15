package media

service: qbittorrent: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                      "qbittorrent"
			"app.kubernetes.io/name": "qbittorrent"
		}
		name: "qbittorrent"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			targetPort: "web"
		}]
		selector: "app.kubernetes.io/name": "qbittorrent"
	}
}
