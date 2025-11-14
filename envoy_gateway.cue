package apps

import ing "github.com/kasuboski/k8s-gitops/networking/envoy_gateway"

import gateway "github.com/envoyproxy/gateway/v1"

apps: "envoy-gateway": {
	namespace: "envoy-gateway-system"
	resources: gateway & ing
}
