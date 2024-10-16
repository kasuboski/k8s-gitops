package josh

deployment: "argocd-repo-server": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "repo-server"
			"app.kubernetes.io/name":      "argocd-repo-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-repo-server"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-repo-server"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-repo-server"
			spec: {
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					podAffinityTerm: {
						labelSelector: matchLabels: "app.kubernetes.io/name": "argocd-repo-server"
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
				automountServiceAccountToken: false
				containers: [{
					args: ["/usr/local/bin/argocd-repo-server"]
					env: [{
						name: "REDIS_PASSWORD"
						valueFrom: secretKeyRef: {
							key:  "auth"
							name: "argocd-redis"
						}
					}, {
						name: "ARGOCD_RECONCILIATION_TIMEOUT"
						valueFrom: configMapKeyRef: {
							key:      "timeout.reconciliation"
							name:     "argocd-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_LOGFORMAT"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.log.format"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_LOGLEVEL"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.log.level"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_PARALLELISM_LIMIT"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.parallelism.limit"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_LISTEN_ADDRESS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.listen.address"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_LISTEN_METRICS_ADDRESS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.metrics.listen.address"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_DISABLE_TLS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.disable.tls"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_MIN_VERSION"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.tls.minversion"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_MAX_VERSION"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.tls.maxversion"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_CIPHERS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.tls.ciphers"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_CACHE_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.repo.cache.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "REDIS_SERVER"
						valueFrom: configMapKeyRef: {
							key:      "redis.server"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "REDIS_COMPRESSION"
						valueFrom: configMapKeyRef: {
							key:      "redis.compression"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "REDISDB"
						valueFrom: configMapKeyRef: {
							key:      "redis.db"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_DEFAULT_CACHE_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.default.cache.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_OTLP_ADDRESS"
						valueFrom: configMapKeyRef: {
							key:      "otlp.address"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_OTLP_INSECURE"
						valueFrom: configMapKeyRef: {
							key:      "otlp.insecure"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_OTLP_HEADERS"
						valueFrom: configMapKeyRef: {
							key:      "otlp.headers"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_MAX_COMBINED_DIRECTORY_MANIFESTS_SIZE"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.max.combined.directory.manifests.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_PLUGIN_TAR_EXCLUSIONS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.plugin.tar.exclusions"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_ALLOW_OUT_OF_BOUNDS_SYMLINKS"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.allow.oob.symlinks"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_STREAMED_MANIFEST_MAX_TAR_SIZE"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.streamed.manifest.max.tar.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_STREAMED_MANIFEST_MAX_EXTRACTED_SIZE"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.streamed.manifest.max.extracted.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_HELM_MANIFEST_MAX_EXTRACTED_SIZE"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.helm.manifest.max.extracted.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_DISABLE_HELM_MANIFEST_MAX_EXTRACTED_SIZE"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.disable.helm.manifest.max.extracted.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REVISION_CACHE_LOCK_TIMEOUT"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.revision.cache.lock.timeout"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_GIT_MODULES_ENABLED"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.enable.git.submodule"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_GIT_LS_REMOTE_PARALLELISM_LIMIT"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.git.lsremote.parallelism.limit"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_GIT_REQUEST_TIMEOUT"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.git.request.timeout"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_GRPC_MAX_SIZE_MB"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.grpc.max.size"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_REPO_SERVER_INCLUDE_HIDDEN_DIRECTORIES"
						valueFrom: configMapKeyRef: {
							key:      "reposerver.include.hidden.directories"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name:  "HELM_CACHE_HOME"
						value: "/helm-working-dir"
					}, {
						name:  "HELM_CONFIG_HOME"
						value: "/helm-working-dir"
					}, {
						name:  "HELM_DATA_HOME"
						value: "/helm-working-dir"
					}]
					image:           "quay.io/argoproj/argocd:v2.12.4"
					imagePullPolicy: "Always"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path: "/healthz?full=true"
							port: 8084
						}
						initialDelaySeconds: 30
						periodSeconds:       30
						timeoutSeconds:      5
					}
					name: "argocd-repo-server"
					ports: [{
						containerPort: 8081
					}, {
						containerPort: 8084
					}]
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8084
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
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
						mountPath: "/app/config/reposerver/tls"
						name:      "argocd-repo-server-tls"
					}, {
						mountPath: "/tmp"
						name:      "tmp"
					}, {
						mountPath: "/helm-working-dir"
						name:      "helm-working-dir"
					}, {
						mountPath: "/home/argocd/cmp-server/plugins"
						name:      "plugins"
					}]
				}]
				initContainers: [{
					command: [
						"/bin/cp",
						"-n",
						"/usr/local/bin/argocd",
						"/var/run/argocd/argocd-cmp-server",
					]
					image: "quay.io/argoproj/argocd:v2.12.4"
					name:  "copyutil"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/var/run/argocd"
						name:      "var-files"
					}]
				}]
				serviceAccountName: "argocd-repo-server"
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
					emptyDir: {}
					name: "helm-working-dir"
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
				}, {
					emptyDir: {}
					name: "var-files"
				}, {
					emptyDir: {}
					name: "plugins"
				}]
			}
		}
	}
}
