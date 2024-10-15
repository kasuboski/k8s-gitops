package metallb

validatingwebhookconfiguration: "metallb-webhook-configuration": {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfiguration"
	metadata: {
		creationTimestamp: null
		name:              "metallb-webhook-configuration"
	}
	webhooks: [{
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta2-bgppeer"
		}
		failurePolicy: "Fail"
		name:          "bgppeersvalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta2"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["bgppeers"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta1-bfdprofile"
		}
		failurePolicy: "Fail"
		name:          "bfdprofilevalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"DELETE",
			]
			resources: ["bfdprofiles"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta1-bgpadvertisement"
		}
		failurePolicy: "Fail"
		name:          "bgpadvertisementvalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["bgpadvertisements"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta1-community"
		}
		failurePolicy: "Fail"
		name:          "communityvalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["communities"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta1-ipaddresspool"
		}
		failurePolicy: "Fail"
		name:          "ipaddresspoolvalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["ipaddresspools"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "metallb-webhook-service"
			namespace: "metallb-system"
			path:      "/validate-metallb-io-v1beta1-l2advertisement"
		}
		failurePolicy: "Fail"
		name:          "l2advertisementvalidationwebhook.metallb.io"
		rules: [{
			apiGroups: ["metallb.io"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["l2advertisements"]
		}]
		sideEffects: "None"
	}]
}
