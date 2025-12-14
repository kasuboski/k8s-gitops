package v1

certificate: "vmks-victoria-metrics-operator-root-ca": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	metadata: {
		name:      "vmks-victoria-metrics-operator-root-ca"
		namespace: "victoria-metrics"
	}
	spec: {
		commonName: "ca.validation.victoriametrics"
		duration:   "63800h0m0s"
		isCA:       true
		issuerRef: name: "vmks-victoria-metrics-operator-root"
		secretName: "vmks-victoria-metrics-operator-root-ca"
	}
}
