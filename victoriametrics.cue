package apps

import "github.com/victoriametrics/victoria-metrics-k8s-stack/v1"

apps: victoriametrics: {
	namespace: "victoria-metrics"
	resources: v1
	resources: _vmOverride
	resources: _vmCertManagerResources
}

_vmOverride: {
	namespace: "victoria-metrics": {
		metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"
	}

	// Add ArgoCD annotation to ValidatingWebhookConfiguration to prevent CRD dependency failures
	validatingwebhookconfiguration: "vmks-victoria-metrics-operator-admission": {
		metadata: annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
	}
}

// Bootstrap CA Pattern for cert-manager webhook certificates
_vmCertManagerResources: {
	// Step 1: SelfSigned Issuer (Bootstrap) - only used to sign the Root CA
	issuer: "vm-operator-bootstrap-issuer": {
		apiVersion: "cert-manager.io/v1"
		kind:       "Issuer"
		metadata: {
			name:      "vm-operator-bootstrap-issuer"
			namespace: "victoria-metrics"
			annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
		}
		spec: selfSigned: {}
	}

	// Step 2: Root CA Certificate - long-lived (10 years), stable trust anchor
	certificate: "vm-operator-root-ca": {
		apiVersion: "cert-manager.io/v1"
		kind:       "Certificate"
		metadata: {
			name:      "vm-operator-root-ca"
			namespace: "victoria-metrics"
			annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
		}
		spec: {
			isCA:       true
			commonName: "vm-operator-root-ca"
			secretName: "vm-operator-root-ca-tls"
			duration:   "87600h" // 10 years
			privateKey: {
				algorithm: "ECDSA"
				size:      256
			}
			issuerRef: {
				name:  "vm-operator-bootstrap-issuer"
				kind:  "Issuer"
				group: "cert-manager.io"
			}
		}
	}

	// Step 3: CA Issuer - signs the actual webhook certificates
	issuer: "vm-operator-issuer": {
		apiVersion: "cert-manager.io/v1"
		kind:       "Issuer"
		metadata: {
			name:      "vm-operator-issuer"
			namespace: "victoria-metrics"
			annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
		}
		spec: ca: secretName: "vm-operator-root-ca-tls"
	}
}
