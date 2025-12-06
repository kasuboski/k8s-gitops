package media

deployment: sonarr: spec: template: spec: {
	containers: [{
		name:  "sonarr"
		image: "lscr.io/linuxserver/sonarr"
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
		ports: [{name: "http", containerPort: 8989}]
		securityContext: {
			runAsNonRoot: false
			// capabilities: drop: ["All"]
		}
		volumeMounts: [{
			name:      "sonarr-config"
			mountPath: "/config"
		}, {
			name:      "media"
			subPath:   "Video/TV Shows"
			mountPath: "/tv"
		},
			{
				name:      "media"
				subPath:   "downloads"
				mountPath: "/downloads"
			}]
	}]
	volumes: [
		{
			name: "sonarr-config"
			persistentVolumeClaim: claimName: "sonarr"
		},
		{
			name: "media"
			persistentVolumeClaim: claimName: "media-storage"
		},
	]
}

httproute: sonarr: {}

persistentvolumeclaim: sonarr: spec: resources: requests: storage: "4Gi"

service: sonarr: {}
