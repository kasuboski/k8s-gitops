package media

deployment: radarr: spec: template: spec: {
	containers: [{
		name:  "radarr"
		image: "lscr.io/linuxserver/radarr"
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
		ports: [{name: "http", containerPort: 7878}]
		securityContext: {
			runAsNonRoot: false
			// capabilities: drop: ["All"]
		}
		volumeMounts: [{
			name:      "radarr-config"
			mountPath: "/config"
		}, {
			name:      "media"
			subPath:   "Video/Movies"
			mountPath: "/movies"
		},
			{
				name:      "media"
				subPath:   "downloads"
				mountPath: "/downloads"
			}]
	}]
	volumes: [
		{
			name: "radarr-config"
			persistentVolumeClaim: claimName: "radarr"
		},
		{
			name: "media"
			persistentVolumeClaim: claimName: "media-storage"
		},
	]
}

httproute: radarr: {}

persistentvolumeclaim: radarr: {}

service: radarr: {}
