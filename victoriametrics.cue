package apps

import "github.com/victoriametrics/victoria-metrics-k8s-stack/v1"

apps: victoriametrics: {
	namespace: "victoria-metrics"
	resources: v1
	resources: _vmOverride
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
