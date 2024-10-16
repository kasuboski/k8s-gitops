package josh

deployment: "argocd-applicationset-controller": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd-applicationset"
		}
		name:      "argocd-applicationset-controller"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-applicationset-controller"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-applicationset-controller"
			spec: {
				containers: [{
					command: [
						"entrypoint.sh",
						"argocd-applicationset-controller",
					]
					env: [{
						name: "NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_LEADER_ELECTION"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.leader.election"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_NAMESPACE"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.namespace"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_REPO_SERVER"
						valueFrom: configMapKeyRef: {
							key:      "repo.server"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_POLICY"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.policy"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_DEBUG"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.debug"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_LOGFORMAT"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.log.format"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_LOGLEVEL"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.log.level"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_DRY_RUN"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.dryrun"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_GIT_MODULES_ENABLED"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.git.submodule"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_PROGRESSIVE_SYNCS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.progressive.syncs"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}]
					image:           "quay.io/argoproj/argocd:v2.6.2"
					imagePullPolicy: "Always"
					name:            "argocd-applicationset-controller"
					ports: [{
						containerPort: 7000
						name:          "webhook"
					}, {
						containerPort: 8080
						name:          "metrics"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/app/config/ssh"
						name:      "ssh-known-hosts"
					}, {
						mountPath: "/app/config/tls"
						name:      "tls-certs"
					}, {
						mountPath: "/app/config/gpg/source"
						name:      "gpg-keys"
					}, {
						mountPath: "/app/config/gpg/keys"
						name:      "gpg-keyring"
					}, {
						mountPath: "/tmp"
						name:      "tmp"
					}]
				}]
				serviceAccountName: "argocd-applicationset-controller"
				volumes: [{
					configMap: name: "argocd-ssh-known-hosts-cm"
					name: "ssh-known-hosts"
				}, {
					configMap: name: "argocd-tls-certs-cm"
					name: "tls-certs"
				}, {
					configMap: name: "argocd-gpg-keys-cm"
					name: "gpg-keys"
				}, {
					emptyDir: {}
					name: "gpg-keyring"
				}, {
					emptyDir: {}
					name: "tmp"
				}]
			}
		}
	}
}