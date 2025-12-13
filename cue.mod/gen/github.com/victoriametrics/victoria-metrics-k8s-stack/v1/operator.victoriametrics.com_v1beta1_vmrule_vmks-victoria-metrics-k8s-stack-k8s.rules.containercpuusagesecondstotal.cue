package v1

vmrule: "vmks-victoria-metrics-k8s-stack-k8s.rules.containercpuusagesecondstotal": {
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
		name:      "vmks-victoria-metrics-k8s-stack-k8s.rules.containercpuusagesecondstotal"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "k8s.rules.container_cpu_usage_seconds_total"
		params: {}
		rules: [{
			annotations: {}
			expr: "sum(rate(container_cpu_usage_seconds_total{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"}[5m])) by(cluster,namespace,pod,container) * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			labels: {}
			record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate5m"
		}, {
			annotations: {}
			expr: "sum(irate(container_cpu_usage_seconds_total{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"}[5m])) by(cluster,namespace,pod,container) * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			labels: {}
			record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate"
		}]
	}]
}
