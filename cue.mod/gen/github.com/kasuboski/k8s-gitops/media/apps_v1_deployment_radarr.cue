package media

deployment: radarr: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                      "radarr"
			"app.kubernetes.io/name": "radarr"
		}
		name: "radarr"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "radarr"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "radarr"
				"app.kubernetes.io/name": "radarr"
			}
			spec: {
				containers: [{
					env: [{
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "linuxserver/radarr"
					livenessProbe: {
						failureThreshold:    5
						initialDelaySeconds: 60
						tcpSocket: port: "http"
						timeoutSeconds: 10
					}
					name: "radarr"
					ports: [{
						containerPort: 7878
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
					volumeMounts: [{
						mountPath: "/config"
						name:      "radarr-config"
					}, {
						mountPath: "/movies"
						name:      "media"
						subPath:   "Video/Movies"
					}, {
						mountPath: "/downloads"
						name:      "media"
						subPath:   "downloads"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				volumes: [{
					name: "radarr-config"
					persistentVolumeClaim: claimName: "radarr"
				}, {
					name: "media"
					persistentVolumeClaim: claimName: "media-storage"
				}]
			}
		}
	}
}