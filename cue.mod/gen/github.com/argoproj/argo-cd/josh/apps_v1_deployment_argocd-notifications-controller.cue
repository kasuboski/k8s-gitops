package josh

deployment: "argocd-notifications-controller": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "argocd-notifications-controller"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-notifications-controller"
		strategy: type: "Recreate"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-notifications-controller"
			spec: {
				containers: [{
					command: ["argocd-notifications"]
					image:           "quay.io/argoproj/argocd:v2.6.2"
					imagePullPolicy: "Always"
					livenessProbe: tcpSocket: port: 9001
					name: "argocd-notifications-controller"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					volumeMounts: [{
						mountPath: "/app/config/tls"
						name:      "tls-certs"
					}, {
						mountPath: "/app/config/reposerver/tls"
						name:      "argocd-repo-server-tls"
					}]
					workingDir: "/app"
				}]
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "argocd-notifications-controller"
				volumes: [{
					configMap: name: "argocd-tls-certs-cm"
					name: "tls-certs"
				}, {
					name: "argocd-repo-server-tls"
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
						secretName: "argocd-repo-server-tls"
					}
				}]
			}
		}
	}
}
