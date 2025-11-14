package media

deployment: lidarr: spec: template: spec: {
	containers: [{
		name:  "lidarr"
		image: "lscr.io/linuxserver/lidarr"
		_envMap: TZ: "America/Chicago"
		env: [for k, v in _envMap {name: k, value: v}]
		resources: {
			requests: cpu:    "100m"
			requests: memory: "128Mi"
			limits: cpu:      "500m"
			limits: memory:   "512Mi"
		}
		readinessProbe: {
			tcpSocket: port: "http"
			initialDelaySeconds: 60
			failureThreshold:    5
			periodSeconds:       10
		}
		livenessProbe: {
			tcpSocket: port: "http"
			initialDelaySeconds: 60
			failureThreshold:    5
			periodSeconds:       10
		}
		ports: [{name: "http", containerPort: 8686}]
		securityContext: {
			runAsNonRoot: false
			// capabilities: drop: ["All"]
		}
		volumeMounts: [{
			name:      "lidarr-config"
			mountPath: "/config"
		}, {
			name:      "media"
			subPath:   "Music"
			mountPath: "/music"
		},
			{
				name:      "media"
				subPath:   "downloads"
				mountPath: "/downloads"
			}]
	}]
	volumes: [
		{
			name: "lidarr-config"
			persistentVolumeClaim: claimName: "lidarr"
		},
		{
			name: "media"
			persistentVolumeClaim: claimName: "media-storage"
		},
	]
}

httproute: lidarr: {}

persistentvolumeclaim: lidarr: {}

service: lidarr: {}
