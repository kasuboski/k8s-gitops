package v1

httproute: "vmagent-vmks-victoria-metrics-k8s-stack": {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRoute"
	metadata: {
		labels: {
			app:                            "vmagent"
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-k8s-stack"
			"app.kubernetes.io/version":    "v1.131.0"
			"helm.sh/chart":                "victoria-metrics-k8s-stack-0.65.1"
		}
		name:      "vmagent-vmks-victoria-metrics-k8s-stack"
		namespace: "victoria-metrics"
	}
	spec: {
		hostnames: ["vmagent.joshcorp.co"]
		parentRefs: [{
			name:      "http"
			namespace: "envoy-gateway-system"
		}]
		rules: [{
			backendRefs: [{
				group:  ""
				kind:   "Service"
				name:   "vmagent-vmks-victoria-metrics-k8s-stack"
				port:   8429
				weight: 1
			}]
			matches: [{
				path: {
					type:  "PathPrefix"
					value: "/"
				}
			}]
		}]
	}
}
