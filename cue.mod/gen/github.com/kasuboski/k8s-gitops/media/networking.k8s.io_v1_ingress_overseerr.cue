package media

ingress: overseerr: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt-prod"
		labels: "app.kubernetes.io/name": "overseerr"
		name: "overseerr"
	}
	spec: {
		ingressClassName: "external-nginx"
		rules: [{
			host: "overseerr.joshcorp.co"
			http: paths: [{
				backend: service: {
					name: "overseerr"
					port: name: "http"
				}
				path:     "/"
				pathType: "ImplementationSpecific"
			}]
		}]
		tls: [{
			hosts: ["overseerr.joshcorp.co"]
			secretName: "overseerr-joshcorp-tls"
		}]
	}
}
