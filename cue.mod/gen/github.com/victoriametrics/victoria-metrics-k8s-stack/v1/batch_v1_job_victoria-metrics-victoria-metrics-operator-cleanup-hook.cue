package v1

job: "victoria-metrics-victoria-metrics-operator-cleanup-hook": {
	apiVersion: "batch/v1"
	kind:       "Job"
	metadata: {
		annotations: {
			"helm.sh/hook":               "pre-delete"
			"helm.sh/hook-delete-policy": "before-hook-creation"
			"helm.sh/hook-weight":        "-3"
		}
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "victoria-metrics-victoria-metrics-operator-cleanup-hook"
		namespace: "victoria-metrics"
	}
	spec: template: {
		metadata: {
			labels: {
				"app.kubernetes.io/instance":   "victoria-metrics"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "victoria-metrics-operator"
				"app.kubernetes.io/version":    "v0.66.1"
				"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
			}
			name: "victoria-metrics-victoria-metrics-operator"
		}
		spec: {
			containers: [{
				args: [
					"delete",
					"vlagent,vlcluster,vlogs,vlsingle,vmagent,vmalert,vmalertmanager,vmalertmanagerconfig,vmanomaly,vmauth,vmcluster,vmnodescrape,vmpodscrape,vmprobe,vmrule,vmscrapeconfig,vmservicescrape,vmsingle,vmstaticscrape,vmuser,vtcluster,vtsingle",
					"--all",
					"--ignore-not-found=true",
				]
				command: ["kubectl"]
				image:           "rancher/kubectl:v1.34.0"
				imagePullPolicy: "IfNotPresent"
				name:            "kubectl"
				resources: {
					limits: {
						cpu:    "500m"
						memory: "256Mi"
					}
					requests: {
						cpu:    "100m"
						memory: "56Mi"
					}
				}
				securityContext: {
					allowPrivilegeEscalation: false
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem: true
				}
			}]
			restartPolicy:      "OnFailure"
			serviceAccountName: "victoria-metrics-victoria-metrics-operator-cleanup-hook"
		}
	}
}
