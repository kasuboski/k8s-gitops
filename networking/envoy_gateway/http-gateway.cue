package envoy_gateway

gateway: http: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "Gateway"
	metadata: name:         "http"
	spec: gatewayClassName: "eg"
	spec: listeners: [
		{
			name:     "http"
			protocol: "HTTP"
			port:     80
			allowedRoutes: namespaces: from: "All"
		},
		{
			name:     "https"
			protocol: "HTTPS"
			port:     443
			hostname: "*.joshcorp.co"
			tls: {
				mode: "Terminate"
				certificateRefs: [
					{
						name: "joshcorp-tls"
						kind: "Secret"
					},
				]
			}
			allowedRoutes: namespaces: from: "All"
		},
	]
}

certificate: "joshcorp-wildcard": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	spec: {
		secretName: "joshcorp-tls"
		issuerRef: {
			name: "letsencrypt-prod"
			kind: "ClusterIssuer"
		}
		commonName: "*.joshcorp.co"
		dnsNames: [
			"*.joshcorp.co",
			"*.int.joshcorp.co",
			"*.ts.joshcorp.co",
		]
	}
}
