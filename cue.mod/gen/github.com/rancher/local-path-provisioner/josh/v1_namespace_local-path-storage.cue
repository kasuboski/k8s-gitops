package josh

namespace: "local-path-storage": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: "pod-security.kubernetes.io/enforce": "privileged"
		name: "local-path-storage"
	}
}
