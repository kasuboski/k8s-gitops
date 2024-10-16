package josh

deployment: "argocd-notifications-controller": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "notifications-controller"
			"app.kubernetes.io/name":      "argocd-notifications-controller"
			"app.kubernetes.io/part-of":   "argocd"
		}
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
					args: ["/usr/local/bin/argocd-notifications"]
					env: [{
						name: "ARGOCD_NOTIFICATIONS_CONTROLLER_LOGFORMAT"
						valueFrom: configMapKeyRef: {
							key:      "notificationscontroller.log.format"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_NOTIFICATIONS_CONTROLLER_LOGLEVEL"
						valueFrom: configMapKeyRef: {
							key:      "notificationscontroller.log.level"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATION_NAMESPACES"
						valueFrom: configMapKeyRef: {
							key:      "application.namespaces"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_NOTIFICATION_CONTROLLER_SELF_SERVICE_NOTIFICATION_ENABLED"
						valueFrom: configMapKeyRef: {
							key:      "notificationscontroller.selfservice.enabled"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}]
					image:           "quay.io/argoproj/argocd:v2.12.4"
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
