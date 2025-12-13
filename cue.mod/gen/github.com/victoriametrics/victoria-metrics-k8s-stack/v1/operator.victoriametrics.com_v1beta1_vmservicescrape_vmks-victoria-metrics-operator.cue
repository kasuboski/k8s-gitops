package v1

vmservicescrape: "vmks-victoria-metrics-operator": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMServiceScrape"
	metadata: {
		annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
		labels: {
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name:      "vmks-victoria-metrics-operator"
		namespace: "victoria-metrics"
	}
	spec: {
		endpoints: [{port: "http"}]
		namespaceSelector: matchNames: ["victoria-metrics"]
		selector: matchLabels: {
			"app.kubernetes.io/instance": "vmks"
			"app.kubernetes.io/name":     "victoria-metrics-operator"
		}
	}
}
