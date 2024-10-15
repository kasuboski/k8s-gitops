package apps

import ds "github.com/kasuboski/k8s-gitops/descheduler"

apps: descheduler: {
	namespace: "kube-system"
	resources: ds
}
