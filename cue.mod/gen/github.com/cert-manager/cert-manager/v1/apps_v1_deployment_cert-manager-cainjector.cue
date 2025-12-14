package v1

deployment: "cert-manager-cainjector": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:                            "cainjector"
			"app.kubernetes.io/component":  "cainjector"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "cainjector"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager-cainjector"
		namespace: "cert-manager"
	}
	spec: {
		replicas: 2
		selector: matchLabels: {
			"app.kubernetes.io/component": "cainjector"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "cainjector"
		}
		template: {
			metadata: {
				annotations: {
					"prometheus.io/path":   "/metrics"
					"prometheus.io/port":   "9402"
					"prometheus.io/scrape": "true"
				}
				labels: {
					app:                            "cainjector"
					"app.kubernetes.io/component":  "cainjector"
					"app.kubernetes.io/instance":   "cert-manager"
					"app.kubernetes.io/managed-by": "Helm"
					"app.kubernetes.io/name":       "cainjector"
					"app.kubernetes.io/version":    "v1.19.2"
					"helm.sh/chart":                "cert-manager-v1.19.2"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					args: [
						"--v=2",
						"--leader-election-namespace=kube-system",
						"--namespace=cert-manager",
						"--enable-certificates-data-source=false",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-cainjector:v1.19.2"
					imagePullPolicy: "IfNotPresent"
					name:            "cert-manager-cainjector"
					ports: [{
						containerPort: 9402
						name:          "http-metrics"
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
				serviceAccountName: "cert-manager-cainjector"
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
