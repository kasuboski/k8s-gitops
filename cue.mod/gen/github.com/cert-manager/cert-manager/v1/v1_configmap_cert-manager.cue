package v1

import "encoding/yaml"

configmap: "cert-manager": {
	apiVersion: "v1"
	data: {
		"config.yaml": yaml.Marshal(_cue_config_yaml)
		let _cue_config_yaml = {
			apiVersion:       "controller.config.cert-manager.io/v1alpha1"
			enableGatewayAPI: true
			kind:             "ControllerConfiguration"
		}, }
	kind: "ConfigMap"
	metadata: {
		labels: {
			app:                            "cert-manager"
			"app.kubernetes.io/component":  "controller"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "cert-manager"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager"
		namespace: "cert-manager"
	}
}
