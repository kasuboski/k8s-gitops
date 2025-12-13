package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-vmalert": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-vmalert"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		interval: "30s"
		name:     "vmalert"
		params: {}
		rules: [{
			alert: "ConfigurationReloadFailure"
			annotations: {
				description: "Configuration hot-reload failed for vmalert on instance {{ $labels.instance }}. Check vmalert's logs for detailed error message."
				summary:     "Configuration reload failed for vmalert instance {{ $labels.instance }}"
			}
			expr: "vmalert_config_last_reload_successful != 1"
			labels: severity: "warning"
		}, {
			alert: "AlertingRulesError"
			annotations: {
				dashboard:   "http://grafana.domain.com/d/LzldHAVnz?viewPanel=13&var-instance={{ $labels.instance }}&var-file={{ $labels.file }}&var-group={{ $labels.group }}&var-cluster={{ $labels.cluster }}"
				description: "Alerting rules execution is failing for \"{{ $labels.alertname }}\" from group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". Check vmalert's logs for detailed error message."
				summary:     "Alerting rules are failing for vmalert instance {{ $labels.instance }}"
			}
			expr: "sum(increase(vmalert_alerting_rules_errors_total[5m])) without(id) > 0"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "RecordingRulesError"
			annotations: {
				dashboard:   "http://grafana.domain.com/d/LzldHAVnz?viewPanel=30&var-instance={{ $labels.instance }}&var-file={{ $labels.file }}&var-group={{ $labels.group }}&var-cluster={{ $labels.cluster }}"
				description: "Recording rules execution is failing for \"{{ $labels.recording }}\" from group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". Check vmalert's logs for detailed error message."
				summary:     "Recording rules are failing for vmalert instance {{ $labels.instance }}"
			}
			expr: "sum(increase(vmalert_recording_rules_errors_total[5m])) without(id) > 0"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "RecordingRulesNoData"
			annotations: {
				dashboard:   "http://grafana.domain.com/d/LzldHAVnz?viewPanel=33&var-file={{ $labels.file }}&var-group={{ $labels.group }}&var-cluster={{ $labels.cluster }}"
				description: "Recording rule \"{{ $labels.recording }}\" from group \"{{ $labels.group }} in file \"{{ $labels.file }}\" produces 0 samples over the last 30min. It might be caused by a misconfiguration or incorrect query expression."
				summary:     "Recording rule {{ $labels.recording }} ({{ $labels.group }}) produces no data"
			}
			expr: "sum(vmalert_recording_rules_last_evaluation_samples) without(id) < 1"
			for:  "30m"
			labels: severity: "info"
		}, {
			alert: "TooManyMissedIterations"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is missing rules evaluations for group \"{{ $labels.group }}\" in file \"{{ $labels.file }}\". The group evaluation time takes longer than the configured evaluation interval. This may result in missed alerting notifications or recording rules samples. Try increasing evaluation interval or concurrency of group \"{{ $labels.group }}\". See https://docs.victoriametrics.com/victoriametrics/vmalert/#groups. If rule expressions are taking longer than expected, please see https://docs.victoriametrics.com/victoriametrics/troubleshooting/#slow-queries."
				summary:     "vmalert instance {{ $labels.instance }} is missing rules evaluations"
			}
			expr: "increase(vmalert_iteration_missed_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteErrors"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to push metrics generated via alerting or recording rules to the configured remote write URL. Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is failing to push metrics to remote write URL"
			}
			expr: "increase(vmalert_remotewrite_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "RemoteWriteDroppingData"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to send results of alerting or recording rules to the configured remote write URL. This may result into gaps in recording rules or alerts state. Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is dropping data sent to remote write URL"
			}
			expr: "increase(vmalert_remotewrite_dropped_rows_total[5m]) > 0"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerErrors"
			annotations: {
				description: "vmalert instance {{ $labels.instance }} is failing to send alert notifications to \"{{ $labels.addr }}\". Check vmalert's logs for detailed error message."
				summary:     "vmalert instance {{ $labels.instance }} is failing to send notifications to Alertmanager"
			}
			expr: "increase(vmalert_alerts_send_errors_total[5m]) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}
