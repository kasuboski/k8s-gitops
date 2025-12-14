package apps

import "github.com/victoriametrics/victoria-metrics-k8s-stack/v1"

apps: victoriametrics: {
	namespace: "victoria-metrics"
	resources: v1
	resources: _vmOverride
	resources: _vlogs
}

_vmOverride: {
	namespace: "victoria-metrics": {
		metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"
	}

	// Add ArgoCD annotation to ValidatingWebhookConfiguration to prevent CRD dependency failures
	validatingwebhookconfiguration: "vmks-victoria-metrics-operator-admission": {
		metadata: annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
	}
}

_vlogs: {
	// PersistentVolume for VictoriaLogs storage
	persistentvolume: "vlog-data": {
		apiVersion: "v1"
		kind:       "PersistentVolume"
		metadata: name: "vlog-data"
		spec: {
			storageClassName: "manual"
			capacity: storage: "50Gi"
			accessModes: ["ReadWriteMany"]
			nfs: {
				server: "zwerg.lan"
				path:   "/storage/vlog"
			}
			nodeAffinity: required: nodeSelectorTerms: [
				{
					matchExpressions: [{
						key:      "topology.kubernetes.io/region"
						operator: "In"
						values: ["home"]
					}, {
						key:      "topology.kubernetes.io/zone"
						operator: "In"
						values: ["austin"]
					}]
				},
			]
		}
	}

	// PersistentVolumeClaim for VictoriaLogs storage
	persistentvolumeclaim: "vlog-data": {
		apiVersion: "v1"
		kind:       "PersistentVolumeClaim"
		metadata: name:      "vlog-data"
		metadata: namespace: "victoria-metrics"
		spec: {
			storageClassName: "manual"
			accessModes: ["ReadWriteMany"]
			resources: requests: storage: "50Gi"
			volumeName: "vlog-data"
		}
	}

	// VLSingle: VictoriaLogs Server
	vlsingle: "victoria-logs-server": {
		apiVersion: "operator.victoriametrics.com/v1"
		kind:       "VLSingle"
		metadata: {
			name:      "victoria-logs-server"
			namespace: "victoria-metrics"
		}
		spec: {
			// Time-based Retention
			retentionPeriod: "15d"

			// Size-based Retention
			retentionDiskSpaceUsage: "50GB"

			// Storage Configuration
			storageDataPath: "/victoria-logs-data"

			volumes: [{
				name: "existing-data-volume"
				persistentVolumeClaim: {
					claimName: "vlog-data"
				}
			}]
			volumeMounts: [{
				name:      "existing-data-volume"
				mountPath: "/victoria-logs-data"
			}]

			// Resource Constraints
			resources: {
				limits: {
					cpu:    "2"
					memory: "4Gi"
				}
				requests: {
					cpu:    "500m"
					memory: "1Gi"
				}
			}
		}
	}

	// VLAgent: Log Collector
	vlagent: "victoria-logs-agent": {
		apiVersion: "operator.victoriametrics.com/v1"
		kind:       "VLAgent"
		metadata: {
			name:      "victoria-logs-agent"
			namespace: "victoria-metrics"
		}
		spec: {
			// Run as DaemonSet to collect logs from all nodes
			k8sCollector: {
				enabled: true
			}

			// Send logs to VLSingle
			remoteWrite: [{
				url: "http://victoria-logs-server.victoria-metrics.svc:9428/insert/jsonline"
			}]

			// Disk Buffer Limits (Ephemeral Storage)
			remoteWriteSettings: {
				maxDiskUsagePerURL: "1GiB"
			}

			// Resource Constraints
			resources: {
				limits: {
					cpu:    "1"
					memory: "1Gi"
				}
				requests: {
					cpu:    "100m"
					memory: "256Mi"
				}
			}
		}
	}
}
