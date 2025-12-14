package v1

issuer: "vmks-victoria-metrics-operator-root": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Issuer"
	metadata: {
		name:      "vmks-victoria-metrics-operator-root"
		namespace: "victoria-metrics"
	}
	spec: selfSigned: {}
}
