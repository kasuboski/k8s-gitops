package v1

import "encoding/yaml"

configmap: "victoria-metrics-victoria-metrics-k8s-stack-grafana-ds": {
	apiVersion: "v1"
	data: {
		"datasource.yaml": yaml.Marshal(_cue_datasource_yaml)
		let _cue_datasource_yaml = {
			apiVersion: 1
			datasources: [{
				access:    "proxy"
				isDefault: true
				name:      "VictoriaMetrics"
				type:      "prometheus"
				url:       "http://vmsingle-victoria-metrics-victoria-metrics-k8s-stack.victoria-metrics.svc.cluster.local.:8428"
			}, {
				access: "proxy"
				jsonData: implementation: "prometheus"
				name: "Alertmanager"
				type: "alertmanager"
				url:  "http://vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack.victoria-metrics.svc.cluster.local.:9093"
			}]
		}, }
	kind: "ConfigMap"
	metadata: {
		labels: {
			app:                            "victoria-metrics-k8s-stack-grafana"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v1.131.0"
			grafana_datasource:             "1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "victoria-metrics-victoria-metrics-k8s-stack-grafana-ds"
		namespace: "victoria-metrics"
	}
}
