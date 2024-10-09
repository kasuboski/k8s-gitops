package apps

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

#Resource: {
  metav1.#PartialObjectMetadata
  ...
}

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
	resources: [string]: [string]: #Resource
}

apps: [string]: #App
apps: [Name=string]: {
	name: Name
  resources: [string]: [string]: metadata: {
    labels: "k8s.joshcorp.co/app": Name
  }
}

appsResources: [string]: [...#Resource]
appsResources: {for appName, a in apps {{(appName): [for _, n in a.resources for name, r in n {r}]}}}

appOut: [...#ArgoApp]
appOut: [for n, a in apps {
	metadata: {
		name: n
	}
	spec: {
		source: {
			targetRevision: "feature/talos"
			path: "manifests/\(n)"
		}
		destination: {
			namespace: a.namespace
		}
	}
}]

appsApp: #ArgoApp
appsApp: {
	metadata: {
		name: "apps"
	}
	spec: {
		source: {
			path: "manifests/apps"
			targetRevision: "feature/talos"
		}
		destination: {
			namespace: "argocd"
		}
	}
}
