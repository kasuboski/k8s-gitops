package v1

deployment: "cert-manager": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                            "cert-manager"
			"app.kubernetes.io/component":  "controller"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "cert-manager"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager"
		namespace: "cert-manager"
	}
	spec: {
		replicas: 2
		selector: matchLabels: {
			"app.kubernetes.io/component": "controller"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cert-manager"
		}
		template: {
			metadata: {
				annotations: {
					"prometheus.io/path":   "/metrics"
					"prometheus.io/port":   "9402"
					"prometheus.io/scrape": "true"
				}
				labels: {
					app:                            "cert-manager"
					"app.kubernetes.io/component":  "controller"
					"app.kubernetes.io/instance":   "cert-manager"
					"app.kubernetes.io/managed-by": "Helm"
					"app.kubernetes.io/name":       "cert-manager"
					"app.kubernetes.io/version":    "v1.19.2"
					"helm.sh/chart":                "cert-manager-v1.19.2"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					args: [
						"--v=2",
						"--cluster-resource-namespace=$(POD_NAMESPACE)",
						"--leader-election-namespace=kube-system",
						"--acme-http01-solver-image=quay.io/jetstack/cert-manager-acmesolver:v1.19.2",
						"--max-concurrent-challenges=60",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-controller:v1.19.2"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 8
						httpGet: {
							path:   "/livez"
							port:   "http-healthz"
							scheme: "HTTP"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      15
					}
					name: "cert-manager-controller"
					ports: [{
						containerPort: 9402
						name:          "http-metrics"
						protocol:      "TCP"
					}, {
						containerPort: 9403
						name:          "http-healthz"
						protocol:      "TCP"
					}]
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					volumeMounts: [{
						mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
						name:      "serviceaccount-token"
						readOnly:  true
					}]
				}]
				enableServiceLinks: false
				nodeSelector: "kubernetes.io/os": "linux"
				priorityClassName: "system-cluster-critical"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "cert-manager"
				volumes: [{
					name: "serviceaccount-token"
					projected: {
						defaultMode: 292
						sources: [{
							serviceAccountToken: {
								expirationSeconds: 3607
								path:              "token"
							}
						}, {
							configMap: {
								items: [{
									key:  "ca.crt"
									path: "ca.crt"
								}]
								name: "kube-root-ca.crt"
							}
						}, {
							downwardAPI: items: [{
								fieldRef: {
									apiVersion: "v1"
									fieldPath:  "metadata.namespace"
								}
								path: "namespace"
							}]
						}]
					}
				}]
			}
		}
	}
}
