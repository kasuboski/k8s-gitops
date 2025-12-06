package descheduler

import "encoding/yaml"

configmap: "descheduler-policy-configmap": {
	apiVersion: "v1"
	data: {
		"policy.yaml": yaml.Marshal(_cue_policy_yaml)
		let _cue_policy_yaml = {
			apiVersion: "descheduler/v1alpha2"
			kind:       "DeschedulerPolicy"
			profiles: [{
				name: "ProfileName"
				pluginConfig: [{
					name: "DefaultEvictor"
					args: nodeFit: true
				}, {
					name: "RemovePodsViolatingInterPodAntiAffinity"
				}, {
					name: "RemoveDuplicates"
				}, {
					name: "LowNodeUtilization"
					args: {
						thresholds: {
							cpu:    20
							memory: 20
							pods:   20
						}
						targetThresholds: {
							cpu:    50
							memory: 50
							pods:   50
						}
					}
				}]
				plugins: {
					balance: enabled: [
						"LowNodeUtilization",
						"RemoveDuplicates",
					]
					deschedule: enabled: ["RemovePodsViolatingInterPodAntiAffinity"]
				}
			}]
		}, }
	kind: "ConfigMap"
	metadata: {
		name:      "descheduler-policy-configmap"
		namespace: "kube-system"
	}
}
