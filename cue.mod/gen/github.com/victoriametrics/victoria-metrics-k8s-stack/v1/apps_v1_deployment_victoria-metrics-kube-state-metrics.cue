package v1

deployment: "victoria-metrics-kube-state-metrics": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "metrics"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "kube-state-metrics"
			"app.kubernetes.io/part-of":    "kube-state-metrics"
			"app.kubernetes.io/version":    "2.17.0"
			"helm.sh/chart":                "kube-state-metrics-6.4.2"
		}
		name:      "victoria-metrics-kube-state-metrics"
		namespace: "victoria-metrics"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "kube-state-metrics"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: labels: {
				"app.kubernetes.io/component":  "metrics"
				"app.kubernetes.io/instance":   "victoria-metrics"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "kube-state-metrics"
				"app.kubernetes.io/part-of":    "kube-state-metrics"
				"app.kubernetes.io/version":    "2.17.0"
				"helm.sh/chart":                "kube-state-metrics-6.4.2"
			}
			spec: {
				automountServiceAccountToken: true
				containers: [{
					args: [
						"--port=8080",
						"--resources=certificatesigningrequests,configmaps,cronjobs,daemonsets,deployments,endpoints,horizontalpodautoscalers,ingresses,jobs,leases,limitranges,mutatingwebhookconfigurations,namespaces,networkpolicies,nodes,persistentvolumeclaims,persistentvolumes,poddisruptionbudgets,pods,replicasets,replicationcontrollers,resourcequotas,secrets,services,statefulsets,storageclasses,validatingwebhookconfigurations,volumeattachments",
					]
					image:           "registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.17.0"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/livez"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      5
					}
					name: "kube-state-metrics"
					ports: [{
						containerPort: 8080
						name:          "http"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/readyz"
							port:   8081
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      5
					}
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
				}]
				dnsPolicy:   "ClusterFirst"
				hostNetwork: false
				securityContext: {
					fsGroup:      65534
					runAsGroup:   65534
					runAsNonRoot: true
					runAsUser:    65534
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "victoria-metrics-kube-state-metrics"
			}
		}
	}
}
