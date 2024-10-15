package kubesystem

apiservice: "v1beta1.metrics.k8s.io": {
	apiVersion: "apiregistration.k8s.io/v1"
	kind:       "APIService"
	metadata: {
		labels: "k8s-app": "metrics-server"
		name: "v1beta1.metrics.k8s.io"
	}
	spec: {
		group:                 "metrics.k8s.io"
		groupPriorityMinimum:  100
		insecureSkipTLSVerify: true
		service: {
			name:      "metrics-server"
			namespace: "kube-system"
		}
		version:         "v1beta1"
		versionPriority: 100
	}
}
