package apps

import sys "github.com/kasuboski/k8s-gitops/kubesystem"

apps: kubesystem: {
	namespace: "kube-system"
	resources: sys
}
