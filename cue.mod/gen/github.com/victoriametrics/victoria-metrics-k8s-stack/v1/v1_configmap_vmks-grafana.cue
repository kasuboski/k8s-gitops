package v1

configmap: "vmks-grafana": {
	apiVersion: "v1"
	data: {
		"grafana.ini": """
			[analytics]
			check_for_updates = true
			[grafana_net]
			url = https://grafana.net
			[log]
			mode = console
			[paths]
			data = /var/lib/grafana/
			logs = /var/log/grafana
			plugins = /var/lib/grafana/plugins
			provisioning = /etc/grafana/provisioning
			[server]
			domain = ''

			"""
		plugins: "victoriametrics-metrics-datasource,victoriametrics-logs-datasource"
	}
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "vmks"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name:      "vmks-grafana"
		namespace: "victoria-metrics"
	}
}
