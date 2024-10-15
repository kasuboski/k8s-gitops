package media

ingress: radarr: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt-prod"
		labels: "app.kubernetes.io/name": "radarr"
		name: "radarr"
	}
	spec: {
		ingressClassName: "external-nginx"
		rules: [{
			host: "radarr.joshcorp.co"
			http: paths: [{
				backend: service: {
					name: "radarr"
					port: name: "http"
				}
				path:     "/"
				pathType: "ImplementationSpecific"
			}]
		}]
		tls: [{
			hosts: ["radarr.joshcorp.co"]
			secretName: "radarr-joshcorp-tls"
		}]
	}
}
