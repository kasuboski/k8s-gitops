package apps

import "github.com/cert-manager/cert-manager/v1"

apps: certmanager: {
	namespace: "cert-manager"
	resources: v1 & _cert
}

_cert: clusterissuer: "letsencrypt-prod": {
	apiVersion: "cert-manager.io/v1"
	kind:       "ClusterIssuer"
	spec: acme: privateKeySecretRef: name: "letsencrypt-prod"
	server: "https://acme-v02.api.letsencrypt.org/directory"
	solvers: [
		{dns01: cloudflare: apiTokenSecretRef: {
			key:  "API_TOKEN"
			name: "cert-manager"
		}
		}]
}
