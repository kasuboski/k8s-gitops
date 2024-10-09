package apps

import sec "github.com/kasuboski/k8s-gitops/secrets"

apps: secrets: {
  namespace: "doppler-operator-system"
  resources: sec
}
