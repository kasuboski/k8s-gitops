package v1

import "encoding/json"

configmap: "victoria-metrics-victoria-metrics-k8s-stack-alertmanager-overview": {
	apiVersion: "v1"
	data: {
		"alertmanager-overview.json": json.Marshal(_cue_alertmanager_overview_json)
		let _cue_alertmanager_overview_json = {
			editable:     false
			graphTooltip: 1
			panels: [{
				collapsed: false
				gridPos: {
					h: 1
					w: 24
					x: 0
					y: 0
				}
				id:    1
				title: "Alerts"
				type:  "row"
			}, {
				datasource: {
					type: "prometheus"
					uid:  "$datasource"
				}
				description: "current set of alerts stored in the Alertmanager"
				fieldConfig: defaults: {
					custom: {
						fillOpacity: 10
						showPoints:  "never"
						stacking: mode: "normal"
					}
					unit: "none"
				}
				gridPos: {
					h: 7
					w: 12
					x: 0
					y: 1
				}
				id: 2
				options: {
					legend: showLegend: false
					tooltip: mode: "multi"
				}
				pluginVersion: "v11.4.0"
				targets: [{
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(alertmanager_alerts{namespace=~\"$namespace\",service=~\"$service\",cluster=~\"$cluster\"}) by(namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
				}]
				title: "Alerts"
				type:  "timeseries"
			}, {
				datasource: {
					type: "prometheus"
					uid:  "$datasource"
				}
				description: "rate of successful and invalid alerts received by the Alertmanager"
				fieldConfig: defaults: {
					custom: {
						fillOpacity: 10
						showPoints:  "never"
						stacking: mode: "normal"
					}
					unit: "ops"
				}
				gridPos: {
					h: 7
					w: 12
					x: 12
					y: 1
				}
				id: 3
				options: {
					legend: showLegend: false
					tooltip: mode: "multi"
				}
				pluginVersion: "v11.4.0"
				targets: [{
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(rate(alertmanager_alerts_received_total{namespace=~\"$namespace\",service=~\"$service\",cluster=~\"$cluster\"}[$__rate_interval])) by(namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}} Received"
				}, {
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(rate(alertmanager_alerts_invalid_total{namespace=~\"$namespace\",service=~\"$service\",cluster=~\"$cluster\"}[$__rate_interval])) by(namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}} Invalid"
				}]
				title: "Alerts receive rate"
				type:  "timeseries"
			}, {
				collapsed: false
				gridPos: {
					h: 1
					w: 24
					x: 0
					y: 8
				}
				id:    4
				title: "Notifications"
				type:  "row"
			}, {
				datasource: {
					type: "prometheus"
					uid:  "$datasource"
				}
				description: "rate of successful and invalid notifications sent by the Alertmanager"
				fieldConfig: defaults: {
					custom: {
						fillOpacity: 10
						showPoints:  "never"
						stacking: mode: "normal"
					}
					unit: "ops"
				}
				gridPos: {
					h: 7
					w: 12
					x: 0
					y: 9
				}
				id: 5
				options: {
					legend: showLegend: false
					tooltip: mode: "multi"
				}
				pluginVersion: "v11.4.0"
				repeat:        "integration"
				targets: [{
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(rate(alertmanager_notifications_total{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(integration,namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}} Total"
				}, {
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(rate(alertmanager_notifications_failed_total{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(integration,namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}} Failed"
				}]
				title: "$integration: Notifications Send Rate"
				type:  "timeseries"
			}, {
				datasource: {
					type: "prometheus"
					uid:  "$datasource"
				}
				description: "latency of notifications sent by the Alertmanager"
				fieldConfig: defaults: {
					custom: {
						fillOpacity: 10
						showPoints:  "never"
						stacking: mode: "normal"
					}
					unit: "s"
				}
				gridPos: {
					h: 7
					w: 12
					x: 12
					y: 9
				}
				id: 6
				options: {
					legend: showLegend: false
					tooltip: mode: "multi"
				}
				pluginVersion: "v11.4.0"
				repeat:        "integration"
				targets: [{
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "histogram_quantile(0.99, sum(rate(alertmanager_notification_latency_seconds_bucket{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(le,namespace,service,instance,cluster))"
					intervalFactor: 2
					legendFormat:   "{{instance}} 99th Percentile"
				}, {
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "histogram_quantile(0.50, sum(rate(alertmanager_notification_latency_seconds_bucket{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(le,namespace,service,instance,cluster))"
					intervalFactor: 2
					legendFormat:   "{{instance}} Median"
				}, {
					datasource: {
						type: "prometheus"
						uid:  "$datasource"
					}
					expr:           "sum(rate(alertmanager_notification_latency_seconds_sum{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(namespace,service,instance,cluster) / sum(rate(alertmanager_notification_latency_seconds_count{namespace=~\"$namespace\",service=~\"$service\",integration=\"$integration\",cluster=~\"$cluster\"}[$__rate_interval])) by(namespace,service,instance,cluster)"
					intervalFactor: 2
					legendFormat:   "{{instance}} Average"
				}]
				title: "$integration: Notification Duration"
				type:  "timeseries"
			}]
			schemaVersion: 39
			tags: ["alertmanager-mixin", "vm-k8s-stack"]
			templating: list: [{
				current: {
					selected: false
					text:     "Prometheus"
					value:    "Prometheus"
				}
				hide:  0
				label: "Data Source"
				name:  "datasource"
				query: "prometheus"
				type:  "datasource"
			}, {
				current: {
					selected: false
					text:     ""
					value:    ""
				}
				datasource: {
					type: "prometheus"
					uid:  "${datasource}"
				}
				label:   "namespace"
				name:    "namespace"
				query:   "label_values(alertmanager_alerts, namespace)"
				refresh: 2
				sort:    1
				type:    "query"
			}, {
				current: {
					selected: false
					text:     ""
					value:    ""
				}
				datasource: {
					type: "prometheus"
					uid:  "${datasource}"
				}
				label:   "service"
				name:    "service"
				query:   "label_values(alertmanager_alerts, service)"
				refresh: 2
				sort:    1
				type:    "query"
			}, {
				current: {
					selected: false
					text:     "$__all"
					value:    "$__all"
				}
				datasource: {
					type: "prometheus"
					uid:  "${datasource}"
				}
				hide:       2
				includeAll: true
				name:       "integration"
				query:      "label_values(alertmanager_notifications_total{integration=~\".*\",cluster=~\"$cluster\"}, integration)"
				refresh:    2
				sort:       1
				type:       "query"
			}, {
				allValue: ".*"
				datasource: type: "prometheus"
				hide:       2
				includeAll: false
				label:      "cluster"
				multi:      false
				name:       "cluster"
				query:      ".*"
				type:       "constant"
			}]
			time: {
				from: "now-1h"
				to:   "now"
			}
			timepicker: refresh_intervals: ["30s"]
			timezone: "utc"
			title:    "Alertmanager / Overview"
			uid:      "alertmanager-overview"
		}, }
	kind: "ConfigMap"
	metadata: {
		labels: {
			app:                            "victoria-metrics-k8s-stack-grafana"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v1.131.0"
			grafana_dashboard:              "1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "victoria-metrics-victoria-metrics-k8s-stack-alertmanager-overview"
		namespace: "victoria-metrics"
	}
}
