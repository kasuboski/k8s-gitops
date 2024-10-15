package media

deployment: lidarr: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                      "lidarr"
			"app.kubernetes.io/name": "lidarr"
		}
		name: "lidarr"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "lidarr"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "lidarr"
				"app.kubernetes.io/name": "lidarr"
			}
			spec: {
				containers: [{
					env: [{
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "lscr.io/linuxserver/lidarr"
					livenessProbe: {
						failureThreshold:    5
						initialDelaySeconds: 60
						tcpSocket: port: "http"
						timeoutSeconds: 10
					}
					name: "lidarr"
					ports: [{
						containerPort: 8686
						name:          "http"
					}]
					readinessProbe: {
						failureThreshold:    5
						initialDelaySeconds: 60
						tcpSocket: port: "http"
						timeoutSeconds: 10
					}
					resources: {
						limits: memory: "512Mi"
						requests: {
							cpu:    "100m"
							memory: "128Mi"
						}
					}
					startupProbe: {
						failureThreshold:    30
						initialDelaySeconds: 5
						periodSeconds:       10
						tcpSocket: port: "http"
					}
					volumeMounts: [{
						mountPath: "/config"
						name:      "lidarr-config"
					}, {
						mountPath: "/music"
						name:      "media"
						subPath:   "Music"
					}, {
						mountPath: "/downloads"
						name:      "media"
						subPath:   "downloads"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				volumes: [{
					name: "lidarr-config"
					persistentVolumeClaim: claimName: "lidarr"
				}, {
					name: "media"
					persistentVolumeClaim: claimName: "media-storage"
				}]
			}
		}
	}
}
