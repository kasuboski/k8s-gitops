package kubesystem

service: "kubelet-serving-cert-approver": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/instance": "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":     "kubelet-serving-cert-approver"
		}
		name:      "kubelet-serving-cert-approver"
		namespace: "kube-system"
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       9090
			protocol:   "TCP"
			targetPort: "metrics"
		}]
		selector: {
			"app.kubernetes.io/instance": "kubelet-serving-cert-approver"
			"app.kubernetes.io/name":     "kubelet-serving-cert-approver"
		}
	}
}
