package v1

issuer: "vmks-victoria-metrics-operator-issuer": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Issuer"
	metadata: {
		name:      "vmks-victoria-metrics-operator-issuer"
		namespace: "victoria-metrics"
	}
	spec: ca: secretName: "vmks-victoria-metrics-operator-root-ca"
}
