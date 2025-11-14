package apps

import webui "github.com/kasuboski/k8s-gitops/openwebui"

apps: openwebui: {
	namespace: "openwebui"
	resources: webui
}
