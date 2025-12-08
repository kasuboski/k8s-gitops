package media

import (
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

namespace: media: corev1.#Namespace & {
	// needed just for the vpn sidecar
	metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"
}

deployment: [Name=string]: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: Name
	metadata: labels: "app.kubernetes.io/name": Name
	metadata: labels: app:                      Name
	spec: {
		strategy: type: "Recreate"
		selector: matchLabels: "app.kubernetes.io/name": Name
		template: {
			metadata: labels: "app.kubernetes.io/name": Name
			metadata: labels: app:                      Name
			spec: securityContext: seccompProfile: type: "RuntimeDefault"
		}
	}
}

service: [Name=string]: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: Name
	metadata: labels: "app.kubernetes.io/name": Name
	metadata: labels: app:                      Name
	spec: {
		selector: "app.kubernetes.io/name": Name
		ports: [
			{
				name:       "http"
				port:       80
				targetPort: "http"
			},
		]
	}
}

persistentvolumeclaim: [Name=string]: {
	metadata: labels: "app.kubernetes.io/name": Name
	metadata: labels: app:                      Name
	spec: {
		storageClassName: string | *"longhorn"
		accessModes: [...string] | *["ReadWriteOnce"]
		resources: requests: storage: string | *"1Gi"
	}
}

httproute: [Name=string]: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRoute"
	metadata: name: Name
	metadata: labels: "app.kubernetes.io/name": Name
	metadata: labels: app:                      Name
	spec: {
		parentRefs: [
			{
				name:      "http"
				namespace: "envoy-gateway-system"
			},
			{
				name:      "cloudflare"
				namespace: "cloudflare-gateway"
			},
		]
		hostnames: [string] | *["\(Name).joshcorp.co"]
		rules: [
			{
				backendRefs: [
					{
						group:  ""
						kind:   "Service"
						name:   string | *Name
						port:   80
						weight: 1
					},
				]
				matches: [
					{
						path: {
							type:  "PathPrefix"
							value: "/"
						}
					},
				]
			},
		]
	}
}

persistentvolumeclaim: "media-storage": spec: {
	accessModes: ["ReadWriteMany"]
	storageClassName: "manual"
	volumeName:       "storage"
	resources: requests: storage: "1Mi"
}
