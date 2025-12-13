package v1

vmrule: "vmks-victoria-metrics-k8s-stack-node-network": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMRule"
	metadata: {
		labels: {
			app:                            "victoria-metrics-k8s-stack"
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v0.28.1"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "vmks-victoria-metrics-k8s-stack-node-network"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "node-network"
		params: {}
		rules: [{
			alert: "NodeNetworkInterfaceFlapping"
			annotations: {
				description: "Network interface \"{{ $labels.device }}\" changing its up status often on node-exporter {{ $labels.namespace }}/{{ $labels.pod }}"
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/general/nodenetworkinterfaceflapping"
				summary:     "Network interface is often changing its status"
			}
			expr: "changes(node_network_up{job=\"node-exporter\",device!~\"veth.+\"}[2m]) > 2"
			for:  "2m"
			labels: severity: "warning"
		}]
	}]
}
