package v1

vmrule: "vmks-victoria-metrics-k8s-stack-vmcluster": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRule"
	metadata: {
		labels: {
			app:                            "victoria-metrics-k8s-stack"
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v0.28.1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "vmks-victoria-metrics-k8s-stack-vmcluster"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		concurrency: 2
		interval:    "30s"
		name:        "vmcluster"
		params: {}
		rules: [{
			alert: "DiskRunsOutOfSpaceIn3Days"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: """
					Taking into account current ingestion rate, free disk space will be enough only for {{ $value | humanizeDuration }} on instance {{ $labels.instance }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space up if possible.
					"""
				summary: "Instance {{ $labels.instance }} will run out of disk space in 3 days"
			}
			expr: "((sum(vm_free_disk_space_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "NodeBecomesReadonlyIn3Days"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: """
					Taking into account current ingestion rate, free disk space and -storage.minFreeDiskSpaceBytes instance {{ $labels.instance }} will remain writable for {{ $value | humanizeDuration }}.
					 Consider to limit the ingestion rate, decrease retention or scale the disk space up if possible.
					"""
				summary: "Instance {{ $labels.instance }} will become read-only in 3 days"
			}
			expr: "((sum(vm_free_disk_space_bytes - vm_free_disk_space_limit_bytes) without(path) / (((rate(vm_rows_added_to_storage_total[1d]) - sum(rate(vm_deduplicated_samples_total[1d])) without(type)) * (sum(vm_data_size_bytes{type!~\"indexdb.*\"}) without(type) / sum(vm_rows{type!~\"indexdb.*\"}) without(type))) + (rate(vm_new_timeseries_created_total[1d]) * (sum(vm_data_size_bytes{type=\"indexdb/file\"}) without(type) / sum(vm_rows{type=\"indexdb/file\"}) without(type))))) < 259200) > 0"
			for:  "30m"
			labels: severity: "warning"
		}, {
			alert: "DiskRunsOutOfSpace"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=20&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: """
					Disk utilisation on instance {{ $labels.instance }} is more than 80%.
					 Having less than 20% of free disk space could cripple merges processes and overall performance. Consider to limit the ingestion rate, decrease retention or scale the disk space if possible.
					"""
				summary: "Instance {{ $labels.instance }} (job={{ $labels.job }}) will run out of disk space soon"
			}
			expr: "(sum(vm_data_size_bytes) by(job,instance,cluster) / (sum(vm_free_disk_space_bytes) by(job,instance,cluster) + sum(vm_data_size_bytes) by(job,instance,cluster))) > 0.8"
			for:  "30m"
			labels: severity: "critical"
		}, {
			alert: "RequestErrorsToAPI"
			annotations: {
				dashboard:   "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=52&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: "Requests to path {{ $labels.path }} are receiving errors. Please verify if clients are sending correct requests."
				summary:     "Too many errors served for {{ $labels.job }} path {{ $labels.path }} (instance {{ $labels.instance }})"
			}
			expr: "increase(vm_http_request_errors_total[5m]) > 0"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "RPCErrors"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=44&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: """
					RPC errors are interconnection errors between cluster components.
					 Possible reasons for errors are misconfiguration, overload, network blips or unreachable components.
					"""
				summary: "Too many RPC errors for {{ $labels.job }} (instance {{ $labels.instance }})"
			}
			expr: "((sum(increase(vm_rpc_connection_errors_total[5m])) by(job,instance,cluster) + sum(increase(vm_rpc_dial_errors_total[5m])) by(job,instance,cluster)) + sum(increase(vm_rpc_handshake_errors_total[5m])) by(job,instance,cluster)) > 0"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}, {
			alert: "TooHighChurnRate"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=102&var-cluster={{ $labels.cluster }}"
				description: """
					VM constantly creates new time series.
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Churn rate is more than 10% for the last 15m"
			}
			expr: "(sum(rate(vm_new_timeseries_created_total[5m])) by(job,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(job,cluster)) > 0.1"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighChurnRate24h"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=102&var-cluster={{ $labels.cluster }}"
				description: """
					The number of created new time series over last 24h is 3x times higher than current number of active series.
					 This effect is known as Churn Rate.
					 High Churn Rate tightly connected with database performance and may result in unexpected OOM's or slow queries.
					"""
				summary: "Too high number of new series created over last 24h"
			}
			expr: "sum(increase(vm_new_timeseries_created_total[24h])) by(job,cluster) > (sum(vm_cache_entries{type=\"storage/hour_metric_ids\"}) by(job,cluster) * 3)"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighSlowInsertsRate"
			annotations: {
				dashboard:   "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=108&var-cluster={{ $labels.cluster }}"
				description: "High rate of slow inserts may be a sign of resource exhaustion for the current load. It is likely more RAM is needed for optimal handling of the current number of active time series. See also https://github.com/VictoriaMetrics/VictoriaMetrics/issues/3976#issuecomment-1476883183"
				summary:     "Percentage of slow inserts is more than 5% for the last 15m"
			}
			expr: "(sum(rate(vm_slow_row_inserts_total[5m])) by(job,cluster) / sum(rate(vm_rows_inserted_total[5m])) by(job,cluster)) > 0.05"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "VminsertVmstorageConnectionIsSaturated"
			annotations: {
				dashboard: "http://grafana.domain.com/d/oS7Bi_0Wz?viewPanel=139&var-instance={{ $labels.instance }}&var-cluster={{ $labels.cluster }}"
				description: """
					The connection between vminsert (instance {{ $labels.instance }}) and vmstorage (instance {{ $labels.addr }}) is saturated by more than 90% and vminsert won't be able to keep up.
					 This usually means that more vminsert or vmstorage nodes must be added to the cluster in order to increase the total number of vminsert -> vmstorage links.
					"""
				summary: "Connection between vminsert on {{ $labels.instance }} and vmstorage on {{ $labels.addr }} is saturated"
			}
			expr: "rate(vm_rpc_send_duration_seconds_total[5m]) > 0.9"
			for:  "15m"
			labels: {
				severity: "warning"
				show_at:  "dashboard"
			}
		}]
	}]
}
