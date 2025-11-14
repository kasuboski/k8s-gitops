package apps

import gate "github.com/kasuboski/k8s-gitops/networking/k8s_gateway"

apps: "k8s-gateway": {
	namespace: "k8s-gateway"
	resources: gate
}
