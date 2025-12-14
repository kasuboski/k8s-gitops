package v1

serviceaccount: "cert-manager": {
	apiVersion:                   "v1"
	automountServiceAccountToken: false
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			app:                            "cert-manager"
			"app.kubernetes.io/component":  "controller"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "cert-manager"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager"
		namespace: "cert-manager"
	}
}
