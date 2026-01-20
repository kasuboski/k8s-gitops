package opencode

_imageTag: "sha-822f02a3e4d14926cfea61c6169eb4d12c501382"

namespace: opencode: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "opencode"
}

deployment: opencode: spec: {
	strategy: type: "Recreate"
	selector: matchLabels: "app.kubernetes.io/name": "opencode"
	template: metadata: labels: {
		app:                      "opencode"
		"app.kubernetes.io/name": "opencode"
	}
	template: spec: {
		securityContext: fsGroup: 1000
		containers: [{
			name:  "opencode"
			image: "ghcr.io/kasuboski/opencode-container:\(_imageTag)"
			ports: [{
				name:          "http"
				containerPort: 4096
			}]
			env: [{
				name: "OPENCODE_SERVER_PASSWORD"
				valueFrom: secretKeyRef: {
					name: "opencode"
					key:  "WEBUI_PASSWORD"
				}
			}]
			resources: {
				requests: cpu:    "250m"
				requests: memory: "512Mi"
				limits: cpu:      "1000m"
				limits: memory:   "2Gi"
			}
			volumeMounts: [{
				name:      "projects"
				subPath:   "opencode-projects"
				mountPath: "/projects"
			}]
			securityContext: {
				allowPrivilegeEscalation: false
				runAsNonRoot:             true
				runAsUser:                1000
				seccompProfile: type: "RuntimeDefault"
				capabilities: drop: ["All"]
			}
		}]
		volumes: [{
			name: "projects"
			persistentVolumeClaim: claimName: "opencode-projects"
		}]
	}
}

persistentvolumeclaim: "opencode-projects": {
	metadata: labels: {
		app:                      "opencode"
		"app.kubernetes.io/name": "opencode"
	}
	spec: {
		storageClassName: "manual"
		accessModes: ["ReadWriteMany"]
		volumeName: "storage-opencode"
		resources: requests: storage: "1Mi"
	}
}

service: opencode: {
	metadata: labels: {
		app:                      "opencode"
		"app.kubernetes.io/name": "opencode"
	}
	spec: {
		selector: "app.kubernetes.io/name": "opencode"
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
	}
}

httproute: opencode: spec: {
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
	hostnames: ["opencode.joshcorp.co"]
	rules: [{
		backendRefs: [{
			group:  ""
			kind:   "Service"
			name:   "opencode"
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
