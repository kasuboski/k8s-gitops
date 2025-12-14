package v1

import "encoding/yaml"

configmap: "vlc-victoria-logs-collector-config": {
	apiVersion: "v1"
	data: {
		"vector.yaml": yaml.Marshal(_cue_vector_yaml)
		let _cue_vector_yaml = {
			data_dir: "/vl-collector"
			sources: k8s: {
				type: "kubernetes_logs"
				pod_annotation_fields: {
					// Disable "pod_ips" as "pod_ip" already includes required info
					pod_ips: ""
				}
			}
			transforms: json_parser: {
				type: "remap"
				inputs: ["k8s"]
				source: """
					.message = parse_json(.message) ?? .message

					"""
			}
			sinks: remote_write_0: {
				type: "http"
				inputs: ["json_parser"]
				uri: "http://vlsingle-victoria-logs-server.victoria-metrics.svc:9428/insert/jsonline"
				encoding: codec: "json"
				framing: method: "newline_delimited"
				healthcheck: enabled: false
				request: headers: {
					AccountID:          "0"
					ProjectID:          "0"
					"VL-Stream-Fields": "kubernetes.pod_name,kubernetes.container_name,kubernetes.pod_namespace"
					"VL-Msg-Field":     "message,msg"
					"VL-Time-Field":    "time,ts,timestamp"
				}
				compression: "zstd"
			}
		}, }
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "vlc"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-logs-collector"
			"helm.sh/chart":                "victoria-logs-collector-0.1.2"
		}
		name:      "vlc-victoria-logs-collector-config"
		namespace: "victoria-metrics"
	}
}
