package v1

deployment: "victoria-metrics-grafana": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name:      "victoria-metrics-grafana"
		namespace: "victoria-metrics"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "grafana"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: {
				annotations: {
					"checksum/config":                         "0e9cbd0ea8e24e32f7dfca5bab17a2ba05652642f0a09a4882833ae88e4cc4a3"
					"checksum/sc-dashboard-provider-config":   "89ec8c9c059a6a61286174130a15d183be69b7a486acc8437afbaf5d790a0ddd"
					"checksum/secret":                         "6da32a1583bfe4b85a1d0f0ee37537bb2486d9f32fbd2e9e896e35e4f5e583aa"
					"kubectl.kubernetes.io/default-container": "grafana"
				}
				labels: {
					"app.kubernetes.io/instance": "victoria-metrics"
					"app.kubernetes.io/name":     "grafana"
					"app.kubernetes.io/version":  "12.3.0"
					"helm.sh/chart":              "grafana-10.1.5"
				}
			}
			spec: {
				automountServiceAccountToken: true
				containers: [{
					env: [{
						name:  "METHOD"
						value: "WATCH"
					}, {
						name:  "LABEL"
						value: "grafana_dashboard"
					}, {
						name:  "LABEL_VALUE"
						value: "1"
					}, {
						name:  "FOLDER"
						value: "/var/lib/grafana/dashboards/default"
					}, {
						name:  "RESOURCE"
						value: "both"
					}, {
						name: "REQ_USERNAME"
						valueFrom: secretKeyRef: {
							key:  "admin-user"
							name: "victoria-metrics-grafana"
						}
					}, {
						name: "REQ_PASSWORD"
						valueFrom: secretKeyRef: {
							key:  "admin-password"
							name: "victoria-metrics-grafana"
						}
					}, {
						name:  "REQ_URL"
						value: "http://localhost:3000/api/admin/provisioning/dashboards/reload"
					}, {
						name:  "REQ_METHOD"
						value: "POST"
					}]
					image:           "quay.io/kiwigrid/k8s-sidecar:1.30.10"
					imagePullPolicy: "IfNotPresent"
					name:            "grafana-sc-dashboard"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/var/lib/grafana/dashboards"
						name:      "sc-dashboard-volume"
					}]
				}, {
					env: [{
						name: "POD_IP"
						valueFrom: fieldRef: fieldPath: "status.podIP"
					}, {
						name: "GF_SECURITY_ADMIN_USER"
						valueFrom: secretKeyRef: {
							key:  "admin-user"
							name: "victoria-metrics-grafana"
						}
					}, {
						name: "GF_SECURITY_ADMIN_PASSWORD"
						valueFrom: secretKeyRef: {
							key:  "admin-password"
							name: "victoria-metrics-grafana"
						}
					}, {
						name:  "GF_PATHS_DATA"
						value: "/var/lib/grafana/"
					}, {
						name:  "GF_PATHS_LOGS"
						value: "/var/log/grafana"
					}, {
						name:  "GF_PATHS_PLUGINS"
						value: "/var/lib/grafana/plugins"
					}, {
						name:  "GF_PATHS_PROVISIONING"
						value: "/etc/grafana/provisioning"
					}]
					image:           "docker.io/grafana/grafana:12.3.0"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 10
						httpGet: {
							path: "/api/health"
							port: 3000
						}
						initialDelaySeconds: 60
						timeoutSeconds:      30
					}
					name: "grafana"
					ports: [{
						containerPort: 3000
						name:          "grafana"
						protocol:      "TCP"
					}, {
						containerPort: 9094
						name:          "gossip-tcp"
						protocol:      "TCP"
					}, {
						containerPort: 9094
						name:          "gossip-udp"
						protocol:      "UDP"
					}, {
						containerPort: 6060
						name:          "profiling"
						protocol:      "TCP"
					}]
					readinessProbe: httpGet: {
						path: "/api/health"
						port: 3000
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/etc/grafana/grafana.ini"
						name:      "config"
						subPath:   "grafana.ini"
					}, {
						mountPath: "/var/lib/grafana"
						name:      "storage"
					}, {
						mountPath: "/var/lib/grafana/dashboards"
						name:      "sc-dashboard-volume"
					}, {
						mountPath: "/etc/grafana/provisioning/dashboards/sc-dashboardproviders.yaml"
						name:      "sc-dashboard-provider"
						subPath:   "provider.yaml"
					}, {
						mountPath: "/etc/grafana/provisioning/datasources"
						name:      "sc-datasources-volume"
					}]
				}]
				enableServiceLinks: true
				initContainers: [{
					env: [{
						name:  "METHOD"
						value: "LIST"
					}, {
						name:  "LABEL"
						value: "grafana_datasource"
					}, {
						name:  "LABEL_VALUE"
						value: "1"
					}, {
						name:  "FOLDER"
						value: "/etc/grafana/provisioning/datasources"
					}, {
						name:  "RESOURCE"
						value: "both"
					}]
					image:           "quay.io/kiwigrid/k8s-sidecar:1.30.10"
					imagePullPolicy: "IfNotPresent"
					name:            "grafana-init-sc-datasources"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/etc/grafana/provisioning/datasources"
						name:      "sc-datasources-volume"
					}]
				}]
				securityContext: {
					fsGroup:      472
					runAsGroup:   472
					runAsNonRoot: true
					runAsUser:    472
				}
				serviceAccountName:    "victoria-metrics-grafana"
				shareProcessNamespace: false
				volumes: [{
					configMap: name: "victoria-metrics-grafana"
					name: "config"
				}, {
					emptyDir: {}
					name: "storage"
				}, {
					emptyDir: {}
					name: "sc-dashboard-volume"
				}, {
					configMap: name: "victoria-metrics-grafana-config-dashboards"
					name: "sc-dashboard-provider"
				}, {
					emptyDir: {}
					name: "sc-datasources-volume"
				}]
			}
		}
	}
}
