package v1

vmrule: "vmks-victoria-metrics-k8s-stack-kubernetes-system-scheduler": {
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
		name:      "vmks-victoria-metrics-k8s-stack-kubernetes-system-scheduler"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "kubernetes-system-scheduler"
		params: {}
		rules: [{
			alert: "KubeSchedulerDown"
			annotations: {
				description: "KubeScheduler has disappeared from Prometheus target discovery."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeschedulerdown"
				summary:     "Target disappeared from Prometheus target discovery."
			}
			expr: "absent(up{job=\"kube-scheduler\"})"
			for:  "15m"
			labels: severity: "critical"
		}]
	}]
}
