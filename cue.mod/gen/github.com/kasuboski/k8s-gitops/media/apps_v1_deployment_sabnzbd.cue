package media

deployment: sabnzbd: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "sabnzbd"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "sabnzbd"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "sabnzbd"
				"app.kubernetes.io/name": "sabnzbd"
			}
			spec: {
				containers: [{
					env: [{
						name:  "PUID"
						value: "1000"
					}, {
						name:  "PGID"
						value: "1000"
					}, {
						name:  "TZ"
						value: "America/Chicago"
					}]
					image: "lscr.io/linuxserver/sabnzbd"
					name:  "sabnzbd"
					ports: [{
						containerPort: 8080
						name:          "web"
					}]
					resources: {
						limits: {
							cpu:    "2000m"
							memory: "2Gi"
						}
						requests: cpu: "100m"
					}
					volumeMounts: [{
						mountPath: "/config"
						name:      "sabnzbd-config"
					}, {
						mountPath: "/downloads"
						name:      "data"
						subPath:   "downloads"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				securityContext: fsGroup: 1000
				volumes: [{
					name: "sabnzbd-config"
					persistentVolumeClaim: claimName: "sabnzbd"
				}, {
					name: "data"
					persistentVolumeClaim: claimName: "media-storage"
				}]
			}
		}
	}
}