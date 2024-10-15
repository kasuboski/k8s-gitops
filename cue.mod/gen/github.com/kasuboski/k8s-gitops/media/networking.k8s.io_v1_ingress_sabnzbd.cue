package media

ingress: sabnzbd: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: "cert-manager.io/cluster-issuer": "letsencrypt-prod"
		labels: "app.kubernetes.io/name": "sabnzbd"
		name: "sabnzbd"
	}
	spec: {
		ingressClassName: "external-nginx"
		rules: [{
			host: "sabnzbd.joshcorp.co"
			http: paths: [{
				backend: service: {
					name: "sabnzbd"
					port: name: "http"
				}
				path:     "/"
				pathType: "ImplementationSpecific"
			}]
		}]
		tls: [{
			hosts: ["sabnzbd.joshcorp.co"]
			secretName: "sabnzbd-joshcorp-tls"
		}]
	}
}
