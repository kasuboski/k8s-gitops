package josh

deployment: "argocd-dex-server": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "dex-server"
			"app.kubernetes.io/name":      "argocd-dex-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-dex-server"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-dex-server"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-dex-server"
			spec: {
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					podAffinityTerm: {
						labelSelector: matchLabels: "app.kubernetes.io/part-of": "argocd"
						topologyKey: "kubernetes.io/hostname"
					}
					weight: 5
				}]
				containers: [{
					command: [
						"/shared/argocd-dex",
						"rundex",
					]
					env: [{
						name: "ARGOCD_DEX_SERVER_DISABLE_TLS"
						valueFrom: configMapKeyRef: {
							key:      "dexserver.disable.tls"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}]
					image:           "ghcr.io/dexidp/dex:v2.35.3"
					imagePullPolicy: "Always"
					name:            "dex"
					ports: [{
						containerPort: 5556
					}, {
						containerPort: 5557
					}, {
						containerPort: 5558
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/shared"
						name:      "static-files"
					}, {
						mountPath: "/tmp"
						name:      "dexconfig"
					}, {
						mountPath: "/tls"
						name:      "argocd-dex-server-tls"
					}]
				}]
				initContainers: [{
					command: [
						"cp",
						"-n",
						"/usr/local/bin/argocd",
						"/shared/argocd-dex",
					]
					image:           "quay.io/argoproj/argocd:v2.6.2"
					imagePullPolicy: "Always"
					name:            "copyutil"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/shared"
						name:      "static-files"
					}, {
						mountPath: "/tmp"
						name:      "dexconfig"
					}]
				}]
				serviceAccountName: "argocd-dex-server"
				volumes: [{
					emptyDir: {}
					name: "static-files"
				}, {
					emptyDir: {}
					name: "dexconfig"
				}, {
					name: "argocd-dex-server-tls"
					secret: {
						items: [{
							key:  "tls.crt"
							path: "tls.crt"
						}, {
							key:  "tls.key"
							path: "tls.key"
						}, {
							key:  "ca.crt"
							path: "ca.crt"
						}]
						optional:   true
						secretName: "argocd-dex-server-tls"
					}
				}]
			}
		}
	}
}
