package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-k8s.rules.containercpurequests": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-k8s.rules.containercpurequests"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "k8s.rules.container_cpu_requests"
		params: {}
		rules: [{
			annotations: {}
			expr: "kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"} * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)"
			labels: {}
			record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests"
		}, {
			annotations: {}
			expr: "sum(sum(max(kube_pod_container_resource_requests{resource=\"cpu\",job=\"kube-state-metrics\"}) by(namespace,pod,container,cluster) * on(namespace,pod,cluster) group_left() max(kube_pod_status_phase{phase=~\"Pending|Running\"} == 1) by(namespace,pod,cluster)) by(namespace,pod,cluster)) by(namespace,cluster)"
			labels: {}
			record: "namespace_cpu:kube_pod_container_resource_requests:sum"
		}]
	}]
}
