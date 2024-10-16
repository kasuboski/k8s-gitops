package josh

deployment: "argocd-applicationset-controller": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "applicationset-controller"
			"app.kubernetes.io/name":      "argocd-applicationset-controller"
			"app.kubernetes.io/part-of":   "argocd"
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
					args: ["/usr/local/bin/argocd-applicationset-controller"]
					env: [{
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_GLOBAL_PRESERVED_ANNOTATIONS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.global.preserved.annotations"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_GLOBAL_PRESERVED_LABELS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.global.preserved.labels"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
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
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_POLICY_OVERRIDE"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.policy.override"
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
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_NEW_GIT_FILE_GLOBBING"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.new.git.file.globbing"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_REPO_SERVER_PLAINTEXT"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.repo.server.plaintext"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_REPO_SERVER_STRICT_TLS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.repo.server.strict.tls"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_REPO_SERVER_TIMEOUT_SECONDS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.repo.server.timeout.seconds"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_CONCURRENT_RECONCILIATIONS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.concurrent.reconciliations.max"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_NAMESPACES"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.namespaces"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_SCM_ROOT_CA_PATH"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.scm.root.ca.path"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ALLOWED_SCM_PROVIDERS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.allowed.scm.providers"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_SCM_PROVIDERS"
						valueFrom: configMapKeyRef: {
							key:      "applicationsetcontroller.enable.scm.providers"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}]
					image:           "quay.io/argoproj/argocd:v2.12.4"
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
					}, {
						mountPath: "/app/config/reposerver/tls"
						name:      "argocd-repo-server-tls"
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
