package v1

deployment: "victoria-metrics-victoria-metrics-operator": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "victoria-metrics-victoria-metrics-operator"
		namespace: "victoria-metrics"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "victoria-metrics-operator"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/instance":   "victoria-metrics"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "victoria-metrics-operator"
			}
			spec: {
				automountServiceAccountToken: true
				containers: [{
					args: [
						"--zap-log-level=info",
						"--leader-elect",
						"--health-probe-bind-address=:8081",
						"--webhook.enable=true",
					]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name:  "OPERATOR_NAME"
						value: "victoria-metrics-operator"
					}, {
						name:  "VM_USECUSTOMCONFIGRELOADER"
						value: "true"
					}, {
						name:  "VM_CUSTOMCONFIGRELOADERIMAGE"
						value: "victoriametrics/operator:config-reloader-v0.66.1"
					}, {
						name:  "VM_ENABLEDPROMETHEUSCONVERTEROWNERREFERENCES"
						value: "false"
					}]
					image:           "victoriametrics/operator:v0.66.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold:    3
						initialDelaySeconds: 5
						periodSeconds:       15
						tcpSocket: port: "probe"
						timeoutSeconds: 5
					}
					name: "operator"
					ports: [{
						containerPort: 8080
						name:          "http"
						protocol:      "TCP"
					}, {
						containerPort: 8081
						name:          "probe"
						protocol:      "TCP"
					}, {
						containerPort: 9443
						name:          "webhook"
						protocol:      "TCP"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/health"
							port:   "probe"
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       15
						timeoutSeconds:      5
					}
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					volumeMounts: [{
						mountPath: "/tmp/k8s-webhook-server/serving-certs"
						name:      "cert"
						readOnly:  true
					}]
				}]
				securityContext: {
					fsGroup:      2000
					runAsNonRoot: true
					runAsUser:    1000
				}
				serviceAccountName:            "victoria-metrics-victoria-metrics-operator"
				terminationGracePeriodSeconds: 30
				volumes: [{
					name: "cert"
					secret: {
						defaultMode: 420
						secretName:  "victoria-metrics-victoria-metrics-operator-validation"
					}
				}]
			}
		}
	}
}
