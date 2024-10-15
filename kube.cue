package apps

import (
	corev1 "k8s.io/api/core/v1"
)

#KindObject: {
	for _, a in apps {for kind, _ in a.resources {(kind): _}}
}
#KindGen: [for k, _ in #KindObject {k}]

// cue eval -e '#KindGen'
#Kinds: ["cronjob", "clusterrole", "clusterrolebinding", "configmap", "serviceaccount", "deployment", "customresourcedefinition", "namespace", "role", "rolebinding", "service", "job", "gatewayclass", "gateway", "apiservice", "validatingwebhookconfiguration", "daemonset", "secret", "ipaddresspool", "l2advertisement", "dopplersecret", "ingress", "storageclass", "persistentvolume", "persistentvolumeclaim", "statefulset", "networkpolicy", "appproject"]

#Schema: {
	for kind in #Kinds {(kind): [string]: #Resource}
}

#Schema: namespace: [string]:      corev1.#Namespace
#Schema: service: [string]:        corev1.#Service
#Schema: serviceaccount: [string]: corev1.#ServiceAccount
