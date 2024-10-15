package media

deployment: prowlarr: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                      "prowlarr"
			"app.kubernetes.io/name": "prowlarr"
		}
		name: "prowlarr"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "prowlarr"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "prowlarr"
				"app.kubernetes.io/name": "prowlarr"
			}
			spec: {
				containers: [{
					env: [{
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "lscr.io/linuxserver/prowlarr:latest"
					name:  "prowlarr"
					ports: [{
						containerPort: 9696
						name:          "http"
					}]
					readinessProbe: {
						failureThreshold: 5
						periodSeconds:    10
						tcpSocket: port: "http"
					}
					resources: {
						limits: {
							cpu:    "500m"
							memory: "256Mi"
						}
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
						name:      "prowlarr-config"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				volumes: [{
					name: "prowlarr-config"
					persistentVolumeClaim: claimName: "prowlarr"
				}]
			}
		}
	}
}
