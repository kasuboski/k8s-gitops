package media

_imageTag: "sha-59f9e969279357aa0a68d0ff26aa74350aadf67d"
deployment: mediaz: spec: template: spec: {
	containers: [{
		name:  "mediaz"
		image: "ghcr.io/kasuboski/mediaz:\(_imageTag)"
		env: [
			{
				name:  "MEDIAZ_CONFIGFILEPATH"
				value: "/etc/mediaz/config.yaml"
			},
			{
				name: "MEDIAZ_TMDB_APIKEY"
				valueFrom: secretKeyRef: {
					name: "media-secret"
					key:  "MEDIAZ_TMDB_APIKEY"
				}
			},
		]
		resources: {
			requests: cpu:    "100m"
			requests: memory: "128Mi"
			limits: cpu:      "500m"
			limits: memory:   "512Mi"
		}
		readinessProbe: {
			httpGet: {
				path: "/healthz"
				port: "http"
			}
			failureThreshold: 5
			periodSeconds:    10
		}
		livenessProbe: {
			httpGet: {
				path: "/healthz"
				port: "http"
			}
			failureThreshold: 5
			periodSeconds:    10
		}
		ports: [{name: "http", containerPort: 8080}]
		securityContext: {
			runAsNonRoot: false
		}
		volumeMounts: [{
			name:      "config"
			mountPath: "/etc/mediaz"
		}, {
			name:      "db"
			mountPath: "/config"
		}, {
			name:      "media"
			subPath:   "Video/Movies"
			mountPath: "/movies"
		}, {
			name:      "media"
			subPath:   "Video/TV Shows"
			mountPath: "/tv"
		}, {
			name:      "media"
			subPath:   "downloads"
			mountPath: "/downloads"
		}]
	}]
	volumes: [
		{
			name: "config"
			configMap: name: "mediaz-config"
		},
		{
			name: "db"
			persistentVolumeClaim: claimName: "mediaz"
		},
		{
			name: "media"
			persistentVolumeClaim: claimName: "media-storage"
		},
	]
}

httproute: mediaz: spec: {
	parentRefs: [
		{
			group:     "gateway.networking.k8s.io"
			kind:      "Gateway"
			name:      "http"
			namespace: "envoy-gateway-system"
		},
	]
}

persistentvolumeclaim: mediaz: spec: resources: requests: storage: "512Mi"

service: mediaz: {}

configmap: "mediaz-config": data: "config.yaml": """
	filePath: /etc/mediaz/config.yaml
	library:
	  downloadMountDir: /downloads
	  movie: /movies
	  tv: /tv
	server:
	  port: 8080
	storage:
	  filePath: /config/mediaz.sqlite
	"""
