package apps

import (
	corev1 "k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
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

#Schema: namespace: [string]:             corev1.#Namespace
#Schema: service: [string]:               corev1.#Service
#Schema: serviceaccount: [string]:        corev1.#ServiceAccount
#Schema: persistentvolume: [string]:      corev1.#PersistentVolume
#Schema: persistentvolumeclaim: [string]: corev1.#PersistentVolumeClaim

#Schema: deployment: [string]:  appsv1.#Deployment
#Schema: statefulset: [string]: appsv1.#StatefulSet
#Schema: daemonset: [string]:   appsv1.#DaemonSet
