package v1

import "encoding/yaml"

configmap: "vmks-grafana-config-dashboards": {
	apiVersion: "v1"
	data: {
		"provider.yaml": yaml.Marshal(_cue_provider_yaml)
		let _cue_provider_yaml = {
			apiVersion: 1
			providers: [{
				name:                  "default"
				orgId:                 1
				folder:                ""
				folderUid:             ""
				type:                  "file"
				disableDeletion:       false
				allowUiUpdates:        false
				updateIntervalSeconds: 30
				options: {
					foldersFromFilesStructure: false
					path:                      "/var/lib/grafana/dashboards/default"
				}
			}]
		}, }
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "vmks"
			"app.kubernetes.io/name":     "grafana"
			"app.kubernetes.io/version":  "12.3.0"
			"helm.sh/chart":              "grafana-10.1.5"
		}
		name:      "vmks-grafana-config-dashboards"
		namespace: "victoria-metrics"
	}
}
