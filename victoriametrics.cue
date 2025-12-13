package apps

import "github.com/victoriametrics/victoria-metrics-k8s-stack/v1"

apps: victoriametrics: {
	namespace: "victoria-metrics"
	resources: v1
	resources: _vmOverride
}

_vmOverride: namespace: "victoria-metrics": {
	metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"
}
