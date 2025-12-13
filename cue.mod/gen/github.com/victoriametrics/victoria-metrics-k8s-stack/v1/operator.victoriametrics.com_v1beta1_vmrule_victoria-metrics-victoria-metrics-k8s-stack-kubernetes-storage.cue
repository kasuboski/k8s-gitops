package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-kubernetes-storage": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRule"
	metadata: {
		labels: {
			app:                            "victoria-metrics-k8s-stack"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v0.28.1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "victoria-metrics-victoria-metrics-k8s-stack-kubernetes-storage"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "kubernetes-storage"
		params: {}
		rules: [{
			alert: "KubePersistentVolumeFillingUp"
			annotations: {
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is only {{ $value | humanizePercentage }} free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: "((((kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_capacity_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.03) and (kubelet_volume_stats_used_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to fill up within four days. Currently {{ $value | humanizePercentage }} is available."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
				summary:     "PersistentVolume is filling up."
			}
			expr: "(((((kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_capacity_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.15) and (kubelet_volume_stats_used_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) and (predict_linear(kubelet_volume_stats_available_bytes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}[6h], 345600) < 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} only has {{ $value | humanizePercentage }} free inodes."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: "((((kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_inodes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.03) and (kubelet_volume_stats_inodes_used{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1m"
			labels: severity: "critical"
		}, {
			alert: "KubePersistentVolumeInodesFillingUp"
			annotations: {
				description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to run out of inodes within four days. Currently {{ $value | humanizePercentage }} of its inodes are free."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
				summary:     "PersistentVolumeInodes are filling up."
			}
			expr: "(((((kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} / kubelet_volume_stats_inodes{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}) < 0.15) and (kubelet_volume_stats_inodes_used{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"} > 0)) and (predict_linear(kubelet_volume_stats_inodes_free{namespace=~\".*\",job=\"kubelet\",metrics_path=\"/metrics\"}[6h], 345600) < 0)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_access_mode{access_mode=\"ReadOnlyMany\"} == 1)) unless on(cluster,namespace,persistentvolumeclaim) (kube_persistentvolumeclaim_labels{label_excluded_from_alerts=\"true\"} == 1)"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "KubePersistentVolumeErrors"
			annotations: {
				description: "The persistent volume {{ $labels.persistentvolume }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} has status {{ $labels.phase }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeerrors"
				summary:     "PersistentVolume is having issues with provisioning."
			}
			expr: "kube_persistentvolume_status_phase{phase=~\"Failed|Pending\",job=\"kube-state-metrics\"} > 0"
			for:  "5m"
			labels: severity: "critical"
		}]
	}]
}
