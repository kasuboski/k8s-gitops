package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-kube-scheduler.rules": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-kube-scheduler.rules"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "kube-scheduler.rules"
		params: {}
		rules: [{
			annotations: {}
			expr: "histogram_quantile(0.99, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.99, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.99, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.99"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.9, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.9, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.9, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.9"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.5, sum(rate(scheduler_scheduling_attempt_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_scheduling_attempt_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.5, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
		}, {
			annotations: {}
			expr: "histogram_quantile(0.5, sum(rate(scheduler_pod_scheduling_sli_duration_seconds_bucket{job=\"kube-scheduler\"}[5m])) without(instance,pod))"
			labels: quantile: "0.5"
			record: "cluster_quantile:scheduler_pod_scheduling_sli_duration_seconds:histogram_quantile"
		}]
	}]
}
