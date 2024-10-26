package apps

import (
	corev1 "k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
	storagev1 "k8s.io/api/storage/v1"
)

#KindObject: {
	for _, a in apps {for kind, _ in a.resources {(kind): _}}
}
#KindGen: [for k, _ in #KindObject {k}]

// cue eval -e '#KindGen'
#Kinds: ["cronjob", "clusterrole", "clusterrolebinding", "configmap", "serviceaccount", "deployment", "customresourcedefinition", "namespace", "role", "rolebinding", "service", "job", "gatewayclass", "gateway", "apiservice", "validatingwebhookconfiguration", "daemonset", "secret", "ipaddresspool", "l2advertisement", "dopplersecret", "storageclass", "persistentvolume", "persistentvolumeclaim", "statefulset", "networkpolicy", "appproject", "httproute"]

#Schema: {
	for kind in #Kinds {(kind): [string]: #Resource}
}

#Schema: namespace: [string]: corev1.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"
}

#Schema: configmap: [string]: corev1.#ConfigMap & {
	apiVersion: "v1"
	kind:       "ConfigMap"
}

#Schema: service: [string]: corev1.#Service & {
	apiVersion: "v1"
	kind:       "Service"
}
#Schema: serviceaccount: [string]: corev1.#ServiceAccount & {
	apiVersion: "v1"
	kind:       "ServiceAccount"
}
#Schema: persistentvolume: [string]: corev1.#PersistentVolume & {
	apiVersion: "v1"
	kind:       "PersistentVolume"
}
#Schema: persistentvolumeclaim: [string]: corev1.#PersistentVolumeClaim & {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
}

#Schema: deployment: [string]: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
}
#Schema: statefulset: [string]: appsv1.#StatefulSet & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
}
#Schema: daemonset: [string]: appsv1.#DaemonSet & {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
}

#Schema: storageclass: [string]: storagev1.#StorageClass & {
	apiVersion: "storage.k8s.io/v1"
	kind:       "StorageClass"
}

#Schema: httproute: [Name=string]: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "HTTPRoute"
	metadata: name: string | *Name
	metadata: labels: "app.kubernetes.io/name": string | *Name
	metadata: labels: app:                      string | *Name
	spec: {
		parentRefs: [...{
			group:     string | *"gateway.networking.k8s.io"
			kind:      string | *"Gateway"
			name:      string
			namespace: string
		}]
		hostnames: [string]
		rules: [...{
			backendRefs: [...{
				group:  string | *""
				kind:   string | *"Service"
				name:   string | *Name
				port:   int | *80
				weight: int | *1
			}]
			matches: [...{
				path: {
					type:  string | *"PathPrefix"
					value: string | *"/"
				}
			}]
		}]
	}
}
