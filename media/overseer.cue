package media

deployment: overseerr: spec: template: spec: {
	containers: [{
		name:  "overseerr"
		image: "sctx/overseerr:1.33.2"
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
			failureThreshold: 5
			periodSeconds:    10
		}
		livenessProbe: {
			tcpSocket: port: "http"
			failureThreshold: 5
			periodSeconds:    10
		}
		ports: [{name: "http", containerPort: 5055}]
		securityContext: {
			runAsNonRoot: false
			// capabilities: drop: ["All"]
		}
		volumeMounts: [{
			name:      "overseerr-config"
			mountPath: "/app/config"
		}]
	}]
	volumes: [
		{
			name: "overseerr-config"
			persistentVolumeClaim: claimName: "overseerr"
		},
	]
}

httproute: overseerr: {}

persistentvolumeclaim: overseerr: {}

service: overseerr: {}
