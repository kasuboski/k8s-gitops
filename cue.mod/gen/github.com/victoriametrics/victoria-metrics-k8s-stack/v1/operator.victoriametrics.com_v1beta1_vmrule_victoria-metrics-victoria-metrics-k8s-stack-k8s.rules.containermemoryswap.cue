package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-k8s.rules.containermemoryswap": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-k8s.rules.containermemoryswap"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "k8s.rules.container_memory_swap"
		params: {}
		rules: [{
			annotations: {}
			expr: "container_memory_swap{job=\"kubelet\",metrics_path=\"/metrics/cadvisor\",image!=\"\"} * on(cluster,namespace,pod) group_left(node) topk(1, max(kube_pod_info{node!=\"\"}) by(cluster,namespace,pod,node)) by(cluster,namespace,pod)"
			labels: {}
			record: "node_namespace_pod_container:container_memory_swap"
		}]
	}]
}
