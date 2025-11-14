package apps

import "github.com/kasuboski/k8s-gitops/storage/local"

apps: "local-storage": {
	namespace: "kube-system"
	resources: local
}
