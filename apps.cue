package apps

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#ArgoApp: metav1.#Object & {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		name:      string
		namespace: string | *"argocd"
		finalizers: [...string] | *["resources-finalizer.argocd.argoproj.io"]
	}
	spec: {
		project: string | *"default"
		source: {
			repoURL:        "https://github.com/kasuboski/k8s-gitops.git"
			targetRevision: string | *"main"
			path:           string
		}
		destination: {
			server:    "https://kubernetes.default.svc"
			namespace: string
		}
		syncPolicy: {
			automated: {
				prune:    bool | *true
				selfHeal: true
			}
			syncOptions: [...string] | *[
				"CreateNamespace=true",
				"PrunePropagationPolicy=foreground",
			]
		}
	}
}

#App: {
	name:      string
	namespace: string
	resources: [...metav1.#Object]
}

apps: [Name=string]: #App & {
	name: Name
}

appOut: [...#ArgoApp]
appOut: [for n, a in apps {
	metadata: {
		name: n
	}
	spec: {
		source: {
			path: n
		}
		destination: {
			namespace: a.namespace
		}
	}
}]
