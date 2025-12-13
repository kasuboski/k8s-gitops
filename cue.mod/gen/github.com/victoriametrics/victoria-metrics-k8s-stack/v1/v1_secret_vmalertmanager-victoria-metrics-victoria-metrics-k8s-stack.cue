package v1

import "encoding/yaml"

secret: "vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "victoria-metrics-k8s-stack-alertmanager"
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v0.28.1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "vmalertmanager-victoria-metrics-victoria-metrics-k8s-stack"
		namespace: "victoria-metrics"
	}
	stringData: {
		"alertmanager.yaml": yaml.Marshal(_cue_alertmanager_yaml)
		let _cue_alertmanager_yaml = {
			receivers: [{name: "blackhole"}]
			route: receiver: "blackhole"
			templates: ["/etc/vm/configs/**/*.tmpl"]
		}, }
}
