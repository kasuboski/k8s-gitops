package apps

import "github.com/rancher/local-path-provisioner/josh"

apps: "local-path-provisioner": {
	namespace: "local-path-storage"
	resources: josh 
}
