package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-general.rules": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-general.rules"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "general.rules"
		params: {}
		rules: [{
			alert: "TargetDown"
			annotations: {
				description: "{{ printf \"%.4g\" $value }}% of the {{ $labels.job }}/{{ $labels.service }} targets in {{ $labels.namespace }} namespace are down."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/targetdown"
				summary:     "One or more targets are unreachable."
			}
			expr: "(100 * (count(up == 0) by(cluster,job,namespace,service) / count(up) by(cluster,job,namespace,service))) > 10"
			for:  "10m"
			labels: severity: "warning"
		}, {
			alert: "Watchdog"
			annotations: {
				description: """
					This is an alert meant to ensure that the entire alerting pipeline is functional.
					This alert is always firing, therefore it should always be firing in Alertmanager
					and always fire against a receiver. There are integrations with various notification
					mechanisms that send a notification when this alert is not firing. For example the
					"DeadMansSnitch" integration in PagerDuty.

					"""
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/watchdog"
				summary:     "An alert that should always be firing to certify that Alertmanager is working properly."
			}
			expr: "vector(1)"
			labels: severity: "none"
		}, {
			alert: "InfoInhibitor"
			annotations: {
				description: """
					This is an alert that is used to inhibit info alerts.
					By themselves, the info-level alerts are sometimes very noisy, but they are relevant when combined with
					other alerts.
					This alert fires whenever there's a severity="info" alert, and stops firing when another alert with a
					severity of 'warning' or 'critical' starts firing on the same namespace.
					This alert should be routed to a null receiver and configured to inhibit alerts with severity="info".

					"""
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/infoinhibitor"
				summary:     "Info-level alert inhibition."
			}
			expr: "(ALERTS{severity=\"info\"} == 1) unless on(namespace,cluster) (ALERTS{alertname!=\"InfoInhibitor\",severity=~\"warning|critical\",alertstate=\"firing\"} == 1)"
			labels: severity: "none"
		}]
	}]
}
