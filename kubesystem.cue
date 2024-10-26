package apps

import sys "github.com/kasuboski/k8s-gitops/kubesystem"

import "github.com/kasuboski/k8s-gitops/genericdeviceplugin"

apps: kubesystem: {
	namespace: "kube-system"
	resources: sys & genericdeviceplugin
}
