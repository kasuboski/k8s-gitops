package v1

vmservicescrape: "victoria-metrics-victoria-metrics-k8s-stack-kube-etcd": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrape"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "victoria-metrics"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v1.131.0"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "victoria-metrics-victoria-metrics-k8s-stack-kube-etcd"
		namespace: "victoria-metrics"
	}
	spec: {
		endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			port:            "http-metrics"
			scheme:          "https"
			tlsConfig: caFile: "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
		}]
		jobLabel: "jobLabel"
		namespaceSelector: matchNames: ["kube-system"]
		selector: matchLabels: {
			app:                          "victoria-metrics-victoria-metrics-k8s-stack-kube-etcd"
			"app.kubernetes.io/instance": "victoria-metrics"
			"app.kubernetes.io/name":     "victoria-metrics-k8s-stack"
			jobLabel:                     "kube-etcd"
		}
	}
}
