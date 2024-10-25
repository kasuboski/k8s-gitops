package apps

import ing "github.com/kasuboski/k8s-gitops/networking/cloudflare_gateway"

import gateway "github.com/pl4nty/cloudflare-kubernetes-gateway/cloudflare"

apps: "cloudflare-gateway": {
	namespace: "cloudflare-gateway"
	resources: gateway & ing
}
