package media

deployment: prowlarr: {
	spec: template: spec: {
		securityContext: fsGroup: 1000
		containers: [{
			name:  "prowlarr"
			image: "lscr.io/linuxserver/prowlarr"
			_envMap: {
				PUID: "1000"
				PGID: "1000"
				TZ:   "America/Chicago"
			}
			env: [for k, v in _envMap {name: k, value: v}]
			resources: {
				requests: cpu:    "100m"
				requests: memory: "128Mi"
				limits: cpu:      "500m"
				limits: memory:   "512Mi"
			}
			readinessProbe: {
				tcpSocket: port: "http"
				failureThreshold: 5
				periodSeconds:    10
			}
			startupProbe: {
				tcpSocket: port: "http"
				initialDelaySeconds: 5
				failureThreshold:    30
				periodSeconds:       10
			}
			ports: [{name: "http", containerPort: 9696}]
			securityContext: {
				runAsNonRoot: true
				capabilities: drop: ["All"]
			}
			volumeMounts: [{
				name:      "prowlarr-config"
				mountPath: "/config"
			}]
		}]
		volumes: [
			{
				name: "prowlarr-config"
				persistentVolumeClaim: claimName: "prowlarr"
			},
		]
	}
}

httproute: prowlarr: {}

persistentvolumeclaim: prowlarr: {}

service: prowlarr: {}
