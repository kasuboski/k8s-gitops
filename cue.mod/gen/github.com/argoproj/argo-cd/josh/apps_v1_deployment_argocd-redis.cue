package josh

deployment: "argocd-redis": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "redis"
			"app.kubernetes.io/name":      "argocd-redis"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-redis"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-redis"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-redis"
			spec: {
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					podAffinityTerm: {
						labelSelector: matchLabels: "app.kubernetes.io/name": "argocd-redis"
						topologyKey: "kubernetes.io/hostname"
					}
					weight: 100
				}, {
					podAffinityTerm: {
						labelSelector: matchLabels: "app.kubernetes.io/part-of": "argocd"
						topologyKey: "kubernetes.io/hostname"
					}
					weight: 5
				}]
				containers: [{
					args: [
						"--save",
						"",
						"--appendonly",
						"no",
					]
					image:           "redis:7.0.7-alpine"
					imagePullPolicy: "Always"
					name:            "redis"
					ports: [{containerPort: 6379}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
					}
				}]
				securityContext: {
					runAsNonRoot: true
					runAsUser:    999
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "argocd-redis"
			}
		}
	}
}
