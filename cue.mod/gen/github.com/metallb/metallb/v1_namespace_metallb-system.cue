package metallb

namespace: "metallb-system": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: {
			"pod-security.kubernetes.io/audit":   "privileged"
			"pod-security.kubernetes.io/enforce": "privileged"
			"pod-security.kubernetes.io/warn":    "privileged"
		}
		name: "metallb-system"
	}
}
