package media

deployment: sabnzbd: {
	spec: template: spec: {
		securityContext: fsGroup: 1000
		containers: [{
			name:  "sabnzbd"
			image: "lscr.io/linuxserver/sabnzbd"
			_envMap: {
				PUID: "1000"
				PGID: "1000"
				TZ:   "America/Chicago"
			}
			env: [for k, v in _envMap {name: k, value: v}]
			resources: {
				requests: cpu:  "100m"
				limits: cpu:    "2000m"
				limits: memory: "2Gi"
			}
			ports: [{name: "http", containerPort: 8080}]
			securityContext: {
				runAsNonRoot: false
				// capabilities: drop: ["All"]
			}
			volumeMounts: [{
				name:      "sabnzbd-config"
				mountPath: "/config"
			}, {
				name:      "data"
				subPath: "downloads"
				mountPath: "/downloads"
			}]
		}]
		volumes: [
			{
				name: "sabnzbd-config"
				persistentVolumeClaim: claimName: "sabnzbd"
			},
			{
				name: "data"
				persistentVolumeClaim: claimName: "media-storage"
			},
		]
	}
}

httproute: sabnzbd: {}

persistentvolumeclaim: sabnzbd: {}

service: sabnzbd: {}
