package apps

import mlb "github.com/metallb/metallb"

import lb "github.com/kasuboski/k8s-gitops/networking/metallb:lb"

apps: metallb: {
	namespace: "metallb-system"
	resources: mlb & lb
}
