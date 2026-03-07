package apps

import (
	"github.com/tailscale/tailscale/v1"
)

apps: tailscale: {
	namespace: "tailscale"
	resources: v1 & _binds
}

_binds: clusterrolebinding: "josh-tailscale": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
	subjects: [
		{
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "User"
			name:     "josh.kasuboski@gmail.com"
		},
	]
}
