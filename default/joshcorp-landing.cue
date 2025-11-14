package default

_imageTag: "aefdbd92d641e8dfa857e06920bca58ff3b50b9f"
deployment: "joshcorp-landing": spec: {
	selector: matchLabels: "app.kubernetes.io/name": "joshcorp-landing"
	template: metadata: labels: {
		app:                      "joshcorp-landing"
		"app.kubernetes.io/name": "joshcorp-landing"
	}
	template: spec: containers: [{
		name:  "joshcorp-landing"
		image: "kasuboski/joshcorp-site:\(_imageTag)"
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		resources: {
			limits: cpu:    "100m"
			limits: memory: "64Mi"
		}
		securityContext: {
			allowPrivilegeEscalation: false
			runAsNonRoot:             true
			runAsUser:                1000
			seccompProfile: type: "RuntimeDefault"
			capabilities: drop: ["All"]
		}
	}]
}

service: "joshcorp-landing": {
	metadata: labels: {
		app:                      "joshcorp-landing"
		"app.kubernetes.io/name": "joshcorp-landing"
	}
	spec: {
		selector: "app.kubernetes.io/name": "joshcorp-landing"
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		}]
	}
}

httproute: backend: spec: {
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
	hostnames: ["joshcorp.co"]
	rules: [{
		backendRefs: [{
			group:  ""
			kind:   "Service"
			name:   "joshcorp-landing"
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
