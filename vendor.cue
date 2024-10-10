package apps

#Download: {
  source: string
}

#Kustomize: {
  path: string
}
#Upstream: {download: #Download} | {kustomize: #Kustomize}

#Vendor: {
  pkg: string
  #Upstream
}
vendor: [PKG=string]: #Vendor & {
  pkg: PKG
}
vendor: "github.com/envoyproxy/gateway/v1": {
  download: {
    source: "https://github.com/envoyproxy/gateway/releases/download/v1.1.2/install.yaml"
  }
}

vendorList: [...#Vendor]
vendorList: [for _, v in vendor {v}]
