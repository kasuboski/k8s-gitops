package apps

import sec "github.com/kasuboski/k8s-gitops/secrets"

import doppler "github.com/DopplerHQ/kubernetes-operator/v1"

apps: secrets: {
	namespace: "doppler-operator-system"
	resources: doppler & sec
}
