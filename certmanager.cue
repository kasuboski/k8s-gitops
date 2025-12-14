package apps

import "github.com/cert-manager/cert-manager/v1"

apps: certmanager: {
	namespace: "cert-manager"
	resources: v1
}
