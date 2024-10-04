package apps

import ing "github.com/kasuboski/k8s-gitops/ingress"

apps: ingress: {
  namespace: "envoy-gateway-system"
  resources: ing
}
