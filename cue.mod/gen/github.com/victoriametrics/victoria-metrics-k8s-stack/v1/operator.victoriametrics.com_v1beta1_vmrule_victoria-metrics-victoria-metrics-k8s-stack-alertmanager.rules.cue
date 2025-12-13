package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-alertmanager.rules": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-alertmanager.rules"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "alertmanager.rules"
		params: {}
		rules: [{
			alert: "AlertmanagerFailedReload"
			annotations: {
				description: "Configuration has failed to load for {{ $labels.namespace }}/{{ $labels.pod}}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerfailedreload"
				summary:     "Reloading an Alertmanager configuration has failed."
			}
			expr: "max_over_time(alertmanager_config_last_reload_successful{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[5m]) == 0"
			for:  "10m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerMembersInconsistent"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} has only found {{ $value }} members of the {{$labels.job}} cluster."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagermembersinconsistent"
				summary:     "A member of an Alertmanager cluster has not found all other cluster members."
			}
			expr: "max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[5m]) < on(namespace,service,cluster) group_left() count(max_over_time(alertmanager_cluster_members{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[5m])) by(namespace,service,cluster)"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerFailedToSendAlerts"
			annotations: {
				description: "Alertmanager {{ $labels.namespace }}/{{ $labels.pod}} failed to send {{ $value | humanizePercentage }} of notifications to {{ $labels.integration }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerfailedtosendalerts"
				summary:     "An Alertmanager instance failed to send notifications."
			}
			expr: "(rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[15m])) > 0.01"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a critical integration."
			}
			expr: "min(rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\",integration=~\".*\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\",integration=~\".*\"}[15m])) by(namespace,service,integration,cluster) > 0.01"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterFailedToSendAlerts"
			annotations: {
				description: "The minimum notification failure rate to {{ $labels.integration }} sent from any instance in the {{$labels.job}} cluster is {{ $value | humanizePercentage }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterfailedtosendalerts"
				summary:     "All Alertmanager instances in a cluster failed to send notifications to a non-critical integration."
			}
			expr: "min(rate(alertmanager_notifications_failed_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\",integration!~\".*\"}[15m]) / ignoring(reason) group_left() rate(alertmanager_notifications_total{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\",integration!~\".*\"}[15m])) by(namespace,service,integration,cluster) > 0.01"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "AlertmanagerConfigInconsistent"
			annotations: {
				description: "Alertmanager instances within the {{$labels.job}} cluster have different configurations."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerconfiginconsistent"
				summary:     "Alertmanager instances within the same cluster have different configurations."
			}
			expr: "count(count_values(\"config_hash\", alertmanager_config_hash{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}) by(namespace,service,cluster)) by(namespace,service,cluster) != 1"
			for:  "20m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterDown"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have been up for less than half of the last 5m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclusterdown"
				summary:     "Half or more of the Alertmanager instances within the same cluster are down."
			}
			expr: "(count(avg_over_time(up{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[5m]) < 0.5) by(namespace,service,cluster) / count(up{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}) by(namespace,service,cluster)) >= 0.5"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "AlertmanagerClusterCrashlooping"
			annotations: {
				description: "{{ $value | humanizePercentage }} of Alertmanager instances within the {{$labels.job}} cluster have restarted at least 5 times in the last 10m."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/alertmanager/alertmanagerclustercrashlooping"
				summary:     "Half or more of the Alertmanager instances within the same cluster are crashlooping."
			}
			expr: "(count(changes(process_start_time_seconds{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}[10m]) > 4) by(namespace,service,cluster) / count(up{job=\"vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack\",container=\"alertmanager\",namespace=\"victoria-metrics\"}) by(namespace,service,cluster)) >= 0.5"
			for:  "5m"
			labels: severity: "critical"
		}]
	}]
}
