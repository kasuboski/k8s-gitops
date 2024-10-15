package media

deployment: sonarr: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                      "sonarr"
			"app.kubernetes.io/name": "sonarr"
		}
		name: "sonarr"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "sonarr"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "sonarr"
				"app.kubernetes.io/name": "sonarr"
			}
			spec: {
				containers: [{
					env: [{
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "linuxserver/sonarr"
					livenessProbe: {
						failureThreshold:    5
						initialDelaySeconds: 60
						tcpSocket: port: "http"
						timeoutSeconds: 10
					}
					name: "sonarr"
					ports: [{
						containerPort: 8989
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
						name:      "sonarr-config"
					}, {
						mountPath: "/tv"
						name:      "media"
						subPath:   "Video/TV Shows"
					}, {
						mountPath: "/downloads"
						name:      "media"
						subPath:   "downloads"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				volumes: [{
					name: "sonarr-config"
					persistentVolumeClaim: claimName: "sonarr"
				}, {
					name: "media"
					persistentVolumeClaim: claimName: "media-storage"
				}]
			}
		}
	}
}
