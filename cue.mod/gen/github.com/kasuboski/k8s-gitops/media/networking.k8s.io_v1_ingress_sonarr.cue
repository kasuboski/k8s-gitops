package media

ingress: sonarr: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt-prod"
		labels: "app.kubernetes.io/name": "sonarr"
		name: "sonarr"
	}
	spec: {
		ingressClassName: "external-nginx"
		rules: [{
			host: "sonarr.joshcorp.co"
			http: paths: [{
				backend: service: {
					name: "sonarr"
					port: name: "http"
				}
				path:     "/"
				pathType: "ImplementationSpecific"
			}]
		}]
		tls: [{
			hosts: ["sonarr.joshcorp.co"]
			secretName: "sonarr-joshcorp-tls"
		}]
	}
}
