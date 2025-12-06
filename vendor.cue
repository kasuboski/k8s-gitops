package apps

#Download: source: string

#Kustomize: path: string
#Upstream: {download: #Download} | {kustomize: #Kustomize}

#Vendor: {
	pkg: string
	#Upstream
}
vendor: [PKG=string]: #Vendor & {
	pkg: PKG
}
vendor: "github.com/envoyproxy/gateway/v1": download: source: "https://github.com/envoyproxy/gateway/releases/download/v1.1.2/install.yaml"

vendor: "github.com/DopplerHQ/kubernetes-operator/v1": download: source: "https://github.com/DopplerHQ/kubernetes-operator/releases/download/v1.5.1/recommended.yaml"
vendor: "github.com/longhorn/longhorn/v1": download: source:             "https://raw.githubusercontent.com/longhorn/longhorn/v1.10.1/deploy/longhorn.yaml"

vendor: "github.com/argoproj/argo-cd/josh": kustomize: path:                           "argocd"
vendor: "github.com/kasuboski/k8s-gitops/kubesystem": kustomize: path:                 "kube-system"
vendor: "github.com/kasuboski/k8s-gitops/descheduler": kustomize: path:                "descheduler"
vendor: "github.com/metallb/metallb": kustomize: path:                                 "networking/metallb"
vendor: "github.com/rancher/local-path-provisioner/josh": kustomize: path:             "storage/local-path-provisioner"
vendor: "github.com/pl4nty/cloudflare-kubernetes-gateway/cloudflare": kustomize: path: "github.com/pl4nty/cloudflare-kubernetes-gateway//config/default?ref=v0.7.0"

vendorList: [...#Vendor]
vendorList: [for _, v in vendor {v}]
