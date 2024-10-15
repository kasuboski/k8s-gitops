package descheduler

cronjob: "descheduler-cronjob": {
	apiVersion: "batch/v1"
	kind:       "CronJob"
	metadata: {
		name:      "descheduler-cronjob"
		namespace: "kube-system"
	}
	spec: {
		concurrencyPolicy: "Forbid"
		jobTemplate: spec: template: {
			metadata: name: "descheduler-pod"
			spec: {
				containers: [{
					args: [
						"--policy-config-file",
						"/policy-dir/policy.yaml",
						"--v",
						"3",
					]
					command: ["/bin/descheduler"]
					image: "registry.k8s.io/descheduler/descheduler:v0.30.1"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/healthz"
							port:   10258
							scheme: "HTTPS"
						}
						initialDelaySeconds: 3
						periodSeconds:       10
					}
					name: "descheduler"
					resources: requests: {
						cpu:    "500m"
						memory: "256Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						privileged:             false
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
					}
					volumeMounts: [{
						mountPath: "/policy-dir"
						name:      "policy-volume"
					}]
				}]
				priorityClassName:  "system-cluster-critical"
				restartPolicy:      "Never"
				serviceAccountName: "descheduler-sa"
				volumes: [{
					configMap: name: "descheduler-policy-configmap"
					name: "policy-volume"
				}]
			}
		}
		schedule: "*/2 * * * *"
	}
}
