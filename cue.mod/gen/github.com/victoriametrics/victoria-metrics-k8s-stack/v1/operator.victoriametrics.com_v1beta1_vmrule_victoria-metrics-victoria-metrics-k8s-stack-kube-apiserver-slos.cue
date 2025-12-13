package v1

vmrule: "victoria-metrics-victoria-metrics-k8s-stack-kube-apiserver-slos": {
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
		name:      "victoria-metrics-victoria-metrics-k8s-stack-kube-apiserver-slos"
		namespace: "victoria-metrics"
	}
	spec: groups: [{
		name: "kube-apiserver-slos"
		params: {}
		rules: [{
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate1h) by(cluster) > 0.14400000000000002) and on(cluster) (sum(apiserver_request:burnrate5m) by(cluster) > 0.14400000000000002)"
			for:  "2m"
			labels: {
				long:     "1h"
				severity: "critical"
				short:    "5m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate6h) by(cluster) > 0.06) and on(cluster) (sum(apiserver_request:burnrate30m) by(cluster) > 0.06)"
			for:  "15m"
			labels: {
				long:     "6h"
				severity: "critical"
				short:    "30m"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate1d) by(cluster) > 0.03) and on(cluster) (sum(apiserver_request:burnrate2h) by(cluster) > 0.03)"
			for:  "1h"
			labels: {
				long:     "1d"
				severity: "warning"
				short:    "2h"
			}
		}, {
			alert: "KubeAPIErrorBudgetBurn"
			annotations: {
				description: "The API server is burning too much error budget on cluster {{ $labels.cluster }}."
				runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
				summary:     "The API server is burning too much error budget."
			}
			expr: "(sum(apiserver_request:burnrate3d) by(cluster) > 0.01) and on(cluster) (sum(apiserver_request:burnrate6h) by(cluster) > 0.01)"
			for:  "3h"
			labels: {
				long:     "3d"
				severity: "warning"
				short:    "6h"
			}
		}]
	}]
}
