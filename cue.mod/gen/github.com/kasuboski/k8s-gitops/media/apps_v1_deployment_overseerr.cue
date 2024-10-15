package media

deployment: overseerr: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                      "overseerr"
			"app.kubernetes.io/name": "overseerr"
		}
		name: "overseerr"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "overseerr"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "overseerr"
				"app.kubernetes.io/name": "overseerr"
			}
			spec: {
				containers: [{
					env: [{
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "sctx/overseerr:1.33.2"
					name:  "overseerr"
					ports: [{
						containerPort: 5055
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
					volumeMounts: [{
						mountPath: "/app/config"
						name:      "overseerr-config"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				volumes: [{
					name: "overseerr-config"
					persistentVolumeClaim: claimName: "overseerr"
				}]
			}
		}
	}
}
