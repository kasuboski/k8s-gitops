package v1

service: "cert-manager-webhook": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                            "webhook"
			"app.kubernetes.io/component":  "webhook"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "webhook"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager-webhook"
		namespace: "cert-manager"
	}
	spec: {
		ports: [{
			name:       "https"
			port:       443
			protocol:   "TCP"
			targetPort: "https"
		}, {
			name:       "metrics"
			port:       9402
			protocol:   "TCP"
			targetPort: "http-metrics"
		}]
		selector: {
			"app.kubernetes.io/component": "webhook"
			"app.kubernetes.io/instance":  "cert-manager"
			"app.kubernetes.io/name":      "webhook"
		}
		type: "ClusterIP"
	}
}
