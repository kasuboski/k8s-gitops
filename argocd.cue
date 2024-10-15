package apps

import "github.com/argoproj/argo-cd/josh"

apps: argocd: {
	namespace: "argocd"
	resources: josh
}
