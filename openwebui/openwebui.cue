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
		securityContext: fsGroup: 1000
		containers: [{
			name:  "openwebui"
			image: "ghcr.io/open-webui/open-webui:\(_imageTag)"
			ports: [{
				name:          "http"
				containerPort: 8080
			}]
			_envMap: {
				OLLAMA_BASE_URL: "https://ollama.joshcorp.co"
				// OAuth configuration for Pocket ID
				ENABLE_OAUTH_SIGNUP:            "true"
				ENABLE_OAUTH_PERSISTENT_CONFIG: "false"
				OAUTH_CLIENT_ID:                "d8654a7c-e2b1-4308-b2d7-7c99d9e9401f"
				OAUTH_PROVIDER_NAME:            "Pocket ID"
				OPENID_PROVIDER_URL:            "https://pocket-id.joshcorp.co/.well-known/openid-configuration"
				OPENID_REDIRECT_URI:            "https://openwebui.joshcorp.co/oauth/oidc/callback"
				OAUTH_MERGE_ACCOUNTS_BY_EMAIL:  "true"
				// Group management
				ENABLE_OAUTH_ROLE_MANAGEMENT:  "true"
				ENABLE_OAUTH_GROUP_MANAGEMENT: "true"
				ENABLE_OAUTH_GROUP_CREATION:   "true"
				OAUTH_ALLOWED_ROLES:           "users, admins"
				OAUTH_ADMIN_ROLES:             "admins"
				OAUTH_ROLES_CLAIM:             "groups"
				OAUTH_SCOPES:                  "openid email profile groups"
				// Additional settings
				DEFAULT_USER_ROLE:             "user"
				ENABLE_LOGIN_FORM:             "false"
				OAUTH_UPDATE_PICTURE_ON_LOGIN: "true"
			}
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
