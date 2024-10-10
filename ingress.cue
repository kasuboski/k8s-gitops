package apps

import ing "github.com/kasuboski/k8s-gitops/ingress"
import gateway "github.com/envoyproxy/gateway/v1"

apps: ingress: {
  namespace: "envoy-gateway-system"
  resources: gateway & ing
}
