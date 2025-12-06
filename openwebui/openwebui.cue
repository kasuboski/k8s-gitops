package openwebui

_imageTag: "v0.6.41"
deployment: openwebui: spec: {
	strategy: type: "Recreate"
	selector: matchLabels: "app.kubernetes.io/name": "openwebui"
	template: metadata: labels: {
		app:                      "openwebui"
		"app.kubernetes.io/name": "openwebui"
	}
	template: spec: {
		securityContext: fsGroup:               1000
		nodeSelector: "kubernetes.io/hostname": "adel"
		containers: [{
			name:  "openwebui"
			image: "ghcr.io/open-webui/open-webui:\(_imageTag)"
			ports: [{
				name:          "http"
				containerPort: 8080
			}]
			_envMap: OLLAMA_BASE_URL: "https://ollama.joshcorp.co"
			env: [for k, v in _envMap {name: k, value: v}]
			envFrom: [
				{
					secretRef: name: "openwebui"
				},
			]
			resources: {
				limits: cpu:    "4000m"
				limits: memory: "4Gi"
				requests: cpu:  "1000m"
			}
			volumeMounts: [{
				name:      "openwebui"
				mountPath: "/app/backend/data"
			}]
			securityContext: {
				allowPrivilegeEscalation: false
				runAsNonRoot:             true
				runAsUser:                1000
				seccompProfile: type: "RuntimeDefault"
				capabilities: drop: ["All"]
			}
		}]
		volumes: [
			{
				name: "openwebui"
				persistentVolumeClaim: claimName: "openwebui"
			},
		]
	}
}

persistentvolumeclaim: [Name=string]: {
	metadata: labels: "app.kubernetes.io/name": Name
	metadata: labels: app:                      Name
	spec: {
		storageClassName: string | *"longhorn"
		accessModes: [...string] | *["ReadWriteOnce"]
		resources: requests: storage: string | *"100Mi"
	}
}

persistentvolumeclaim: openwebui: spec: resources: requests: storage: "25Gi"

service: openwebui: {
	metadata: labels: {
		app:                      "openwebui"
		"app.kubernetes.io/name": "openwebui"
	}
	spec: {
		selector: "app.kubernetes.io/name": "openwebui"
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
	}
}

httproute: webui: spec: {
	parentRefs: [
		{
			group:     "gateway.networking.k8s.io"
			kind:      "Gateway"
			name:      "http"
			namespace: "envoy-gateway-system"
		},
		{
			group:     "gateway.networking.k8s.io"
			kind:      "Gateway"
			name:      "cloudflare"
			namespace: "cloudflare-gateway"
		},
	]
	hostnames: ["openwebui.joshcorp.co"]
	rules: [{
		backendRefs: [{
			group:  ""
			kind:   "Service"
			name:   "openwebui"
			port:   80
			weight: 1
		}]
		matches: [{
			path: {
				type:  "PathPrefix"
				value: "/"
			}
		}]
	}]
}
