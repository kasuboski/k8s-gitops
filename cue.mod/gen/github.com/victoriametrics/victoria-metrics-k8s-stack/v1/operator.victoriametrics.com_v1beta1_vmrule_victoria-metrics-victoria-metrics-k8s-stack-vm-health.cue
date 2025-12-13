package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-vm-health": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-vm-health"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "vm-health"
		params: {}
		rules: [{
			alert: "TooManyRestarts"
			annotations: {
				description: """
					Job {{ $labels.job }} (instance {{ $labels.instance }}) has restarted more than twice in the last 15 minutes. It might be crashlooping.

					"""
				summary: "{{ $labels.job }} too many restarts (instance {{ $labels.instance }})"
			}
			expr: "changes(process_start_time_seconds{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"}[15m]) > 2"
			labels: severity: "critical"
		}, {
			alert: "ServiceDown"
			annotations: {
				description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 2 minutes."
				summary:     "Service {{ $labels.job }} is down on {{ $labels.instance }}"
			}
			expr: "up{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"} == 0"
			for:  "2m"
			labels: severity: "critical"
		}, {
			alert: "ProcessNearFDLimits"
			annotations: {
				description: """
					Exhausting OS file descriptors limit can cause severe degradation of the process.
					Consider to increase the limit as fast as possible.

					"""
				summary: "Number of free file descriptors is less than 100 for \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") for the last 5m"
			}
			expr: "(process_max_fds - process_open_fds) < 100"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighMemoryUsage"
			annotations: {
				description: """
					Too high memory usage may result into multiple issues such as OOMs or degraded performance.
					Consider to either increase available memory or decrease the load on the process.

					"""
				summary: "It is more than 80% of memory used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\")"
			}
			expr: "(min_over_time(process_resident_memory_anon_bytes[10m]) / vm_available_memory_bytes) > 0.8"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighCPUUsage"
			annotations: {
				description: """
					Too high CPU usage may be a sign of insufficient resources and make process unstable. Consider to either increase available CPU resources or decrease the load on the process.

					"""
				summary: "More than 90% of CPU is used by \"{{ $labels.job }}\"(\"{{ $labels.instance }}\") during the last 5m"
			}
			expr: "(rate(process_cpu_seconds_total[5m]) / process_cpu_cores_available) > 0.9"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "TooHighGoroutineSchedulingLatency"
			annotations: {
				description: """
					Go runtime is unable to schedule goroutines execution in acceptable time. This is usually a sign of insufficient CPU resources or CPU throttling. Verify that service has enough CPU resources. Otherwise, the service could work unreliably with delays in processing.

					"""
				summary: "\"{{ $labels.job }}\"(\"{{ $labels.instance }}\") has insufficient CPU resources for >15m"
			}
			expr: "histogram_quantile(0.99, sum(rate(go_sched_latencies_seconds_bucket{job=~\".*(victoriametrics|vmselect|vminsert|vmstorage|vmagent|vmalert|vmsingle|vmalertmanager|vmauth).*\"}[5m])) by(le,job,instance,cluster)) > 0.1"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "TooManyLogs"
			annotations: {
				description: """
					Logging rate for job \\"{{ $labels.job }}\\" ({{ $labels.instance }}) is {{ $value }} for last 15m. Worth to check logs for specific error messages.

					"""
				summary: "Too many logs printed for job \"{{ $labels.job }}\" ({{ $labels.instance }})"
			}
			expr: "sum(increase(vm_log_messages_total{level=\"error\"}[5m])) without(app_version,location) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooManyTSIDMisses"
			annotations: {
				description: """
					Unexpected TSID misses for \\"{{ $labels.job }}\\" ({{ $labels.instance }}) for the last 15 minutes.
					If this happens after unclean shutdown of VictoriaMetrics process (via \\"kill -9\\", OOM or power off),
					then this is OK - the alert must go away in a few minutes after the restart.
					Otherwise this may point to the corruption of index data.

					"""
				summary: "Unexpected TSID misses for job \"{{ $labels.job }}\" ({{ $labels.instance }}) for the last 15 minutes"
			}
			expr: "increase(vm_missing_tsids_for_metric_id_total[5m]) > 0"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "ConcurrentInsertsHitTheLimit"
			annotations: {
				description: """
					The limit of concurrent inserts on instance {{ $labels.instance }} depends on the number of CPUs.
					Usually, when component constantly hits the limit it is likely the component is overloaded and requires more CPU.
					In some cases for components like vmagent or vminsert the alert might trigger if there are too many clients
					making write attempts. If vmagent's or vminsert's CPU usage and network saturation are at normal level, then 
					it might be worth adjusting `-maxConcurrentInserts` cmd-line flag.

					"""
				summary: "{{ $labels.job }} on instance {{ $labels.instance }} is constantly hitting concurrent inserts limit"
			}
			expr: "avg_over_time(vm_concurrent_insert_current[1m]) >= vm_concurrent_insert_capacity"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "IndexDBRecordsDrop"
			annotations: {
				description: """
					VictoriaMetrics could skip registering new timeseries during ingestion if they fail the validation process. 
					For example, `reason=too_long_item` means that time series cannot exceed 64KB. Please, reduce the number 
					of labels or label values for such series. Or enforce these limits via `-maxLabelsPerTimeseries` and 
					`-maxLabelValueLen` command-line flags.

					"""
				summary: "IndexDB skipped registering items during data ingestion with reason={{ $labels.reason }}."
			}
			expr: "increase(vm_indexdb_items_dropped_total[5m]) > 0"
			labels: severity: "critical"
		}, {
			alert: "RowsRejectedOnIngestion"
			annotations: {
				description: "Ingested rows on instance \"{{ $labels.instance }}\" are rejected due to the following reason: \"{{ $labels.reason }}\""
				summary:     "Some rows are rejected on \"{{ $labels.instance }}\" on ingestion attempt"
			}
			expr: "rate(vm_rows_ignored_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "TooHighQueryLoad"
			annotations: {
				description: """
					Instance {{ $labels.instance }} ({{ $labels.job }}) is failing to serve read queries during last 15m.
					Concurrency limit `-search.maxConcurrentRequests` was reached on this instance and extra queries were
					put into the queue for `-search.maxQueueDuration` interval. But even after waiting in the queue these queries weren't served.
					This happens if instance is overloaded with the current workload, or datasource is too slow to respond.
					Possible solutions are the following:
					* reduce the query load;
					* increase compute resources or number of replicas;
					* adjust limits `-search.maxConcurrentRequests` and `-search.maxQueueDuration`.
					See more at https://docs.victoriametrics.com/victoriametrics/troubleshooting/#slow-queries.

					"""
				summary: "Read queries fail with timeout for {{ $labels.job }} on instance {{ $labels.instance }}"
			}
			expr: "increase(vm_concurrent_select_limit_timeout_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}
