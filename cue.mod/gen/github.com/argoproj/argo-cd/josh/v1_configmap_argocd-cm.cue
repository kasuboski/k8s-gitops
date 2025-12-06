package josh

import "encoding/yaml"

configmap: "argocd-cm": {
	apiVersion: "v1"
	data: {
		"admin.enabled":           "false"
		"resource.customizations": yaml.Marshal(_cue_resource_customizations)
		let _cue_resource_customizations = {
			"apiextensions.k8s.io/CustomResourceDefinition": {
				ignoreDifferences: yaml.Marshal(_cue_ignoreDifferences)
				let _cue_ignoreDifferences = {
					jsonPointers: ["/status"]
				}, }
			"admissionregistration.k8s.io/ValidatingWebhookConfiguration": {
				ignoreDifferences: yaml.Marshal(_cue_xignoreDifferences)
				let _cue_xignoreDifferences = {
					jsonPointers: [
						"/webhooks/0/clientConfig/caBundle",
						"/webhooks/1/clientConfig/caBundle",
					]
				}, }
		}
		"statusbadge.enabled":     "true"
		"users.anonymous.enabled": "true"
	}
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "argocd-cm"
			"app.kubernetes.io/part-of": "argocd"
		}
		name:      "argocd-cm"
		namespace: "argocd"
	}
}
