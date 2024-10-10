package josh

deployment: "argocd-server": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "server"
			"app.kubernetes.io/name":      "argocd-server"
			"app.kubernetes.io/part-of":   "argocd"
		}
		name:      "argocd-server"
		namespace: "argocd"
	}
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "argocd-server"
		template: {
			metadata: labels: "app.kubernetes.io/name": "argocd-server"
			spec: {
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					podAffinityTerm: {
						labelSelector: matchLabels: "app.kubernetes.io/name": "argocd-server"
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
					command: ["argocd-server"]
					env: [{
						name: "ARGOCD_SERVER_INSECURE"
						valueFrom: configMapKeyRef: {
							key:      "server.insecure"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_BASEHREF"
						valueFrom: configMapKeyRef: {
							key:      "server.basehref"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_ROOTPATH"
						valueFrom: configMapKeyRef: {
							key:      "server.rootpath"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_LOGFORMAT"
						valueFrom: configMapKeyRef: {
							key:      "server.log.format"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_LOG_LEVEL"
						valueFrom: configMapKeyRef: {
							key:      "server.log.level"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_REPO_SERVER"
						valueFrom: configMapKeyRef: {
							key:      "repo.server"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_DEX_SERVER"
						valueFrom: configMapKeyRef: {
							key:      "server.dex.server"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_DISABLE_AUTH"
						valueFrom: configMapKeyRef: {
							key:      "server.disable.auth"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_ENABLE_GZIP"
						valueFrom: configMapKeyRef: {
							key:      "server.enable.gzip"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_REPO_SERVER_TIMEOUT_SECONDS"
						valueFrom: configMapKeyRef: {
							key:      "server.repo.server.timeout.seconds"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_X_FRAME_OPTIONS"
						valueFrom: configMapKeyRef: {
							key:      "server.x.frame.options"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_CONTENT_SECURITY_POLICY"
						valueFrom: configMapKeyRef: {
							key:      "server.content.security.policy"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_REPO_SERVER_PLAINTEXT"
						valueFrom: configMapKeyRef: {
							key:      "server.repo.server.plaintext"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_REPO_SERVER_STRICT_TLS"
						valueFrom: configMapKeyRef: {
							key:      "server.repo.server.strict.tls"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_DEX_SERVER_PLAINTEXT"
						valueFrom: configMapKeyRef: {
							key:      "server.dex.server.plaintext"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_DEX_SERVER_STRICT_TLS"
						valueFrom: configMapKeyRef: {
							key:      "server.dex.server.strict.tls"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_MIN_VERSION"
						valueFrom: configMapKeyRef: {
							key:      "server.tls.minversion"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_MAX_VERSION"
						valueFrom: configMapKeyRef: {
							key:      "server.tls.maxversion"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_TLS_CIPHERS"
						valueFrom: configMapKeyRef: {
							key:      "server.tls.ciphers"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_CONNECTION_STATUS_CACHE_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "server.connection.status.cache.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_OIDC_CACHE_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "server.oidc.cache.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_LOGIN_ATTEMPTS_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "server.login.attempts.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_STATIC_ASSETS"
						valueFrom: configMapKeyRef: {
							key:      "server.staticassets"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_APP_STATE_CACHE_EXPIRATION"
						valueFrom: configMapKeyRef: {
							key:      "server.app.state.cache.expiration"
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
							key:      "server.default.cache.expiration"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_MAX_COOKIE_NUMBER"
						valueFrom: configMapKeyRef: {
							key:      "server.http.cookie.maxnumber"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}, {
						name: "ARGOCD_SERVER_OTLP_ADDRESS"
						valueFrom: configMapKeyRef: {
							key:      "otlp.address"
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
						name: "ARGOCD_SERVER_ENABLE_PROXY_EXTENSION"
						valueFrom: configMapKeyRef: {
							key:      "server.enable.proxy.extension"
							name:     "argocd-cmd-params-cm"
							optional: true
						}
					}]
					image:           "quay.io/argoproj/argocd:v2.6.2"
					imagePullPolicy: "Always"
					livenessProbe: {
						httpGet: {
							path: "/healthz?full=true"
							port: 8080
						}
						initialDelaySeconds: 3
						periodSeconds:       30
						timeoutSeconds:      5
					}
					name: "argocd-server"
					ports: [{
						containerPort: 8080
					}, {
						containerPort: 8083
					}]
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8080
						}
						initialDelaySeconds: 3
						periodSeconds:       30
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
						mountPath: "/app/config/server/tls"
						name:      "argocd-repo-server-tls"
					}, {
						mountPath: "/app/config/dex/tls"
						name:      "argocd-dex-server-tls"
					}, {
						mountPath: "/home/argocd"
						name:      "plugins-home"
					}, {
						mountPath: "/tmp"
						name:      "tmp"
					}]
				}]
				serviceAccountName: "argocd-server"
				volumes: [{
					emptyDir: {}
					name: "plugins-home"
				}, {
					emptyDir: {}
					name: "tmp"
				}, {
					configMap: name: "argocd-ssh-known-hosts-cm"
					name: "ssh-known-hosts"
				}, {
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
				}, {
					name: "argocd-dex-server-tls"
					secret: {
						items: [{
							key:  "tls.crt"
							path: "tls.crt"
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
