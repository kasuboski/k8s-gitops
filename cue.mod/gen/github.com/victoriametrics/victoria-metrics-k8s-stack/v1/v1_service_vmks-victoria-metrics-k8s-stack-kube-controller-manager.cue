package v1

service: "vmks-victoria-metrics-k8s-stack-kube-controller-manager": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                            "vmks-victoria-metrics-k8s-stack-kube-controller-manager"
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v1.131.0"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
			jobLabel:                       "kube-controller-manager"
		}
		name:      "vmks-victoria-metrics-k8s-stack-kube-controller-manager"
		namespace: "kube-system"
	}
	spec: {
		clusterIP: "None"
		ports: [{
			name:       "http-metrics"
			port:       10257
			protocol:   "TCP"
			targetPort: 10257
		}]
		selector: component: "kube-controller-manager"
		type: "ClusterIP"
	}
}
