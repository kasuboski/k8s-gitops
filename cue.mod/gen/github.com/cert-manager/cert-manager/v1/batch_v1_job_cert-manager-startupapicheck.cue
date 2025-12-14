package v1

job: "cert-manager-startupapicheck": {
	apiVersion: "batch/v1"
	kind:       "Job"
	metadata: {
		annotations: {
			"helm.sh/hook":               "post-install"
			"helm.sh/hook-delete-policy": "before-hook-creation,hook-succeeded"
			"helm.sh/hook-weight":        "1"
		}
		labels: {
			app:                            "startupapicheck"
			"app.kubernetes.io/component":  "startupapicheck"
			"app.kubernetes.io/instance":   "cert-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "startupapicheck"
			"app.kubernetes.io/version":    "v1.19.2"
			"helm.sh/chart":                "cert-manager-v1.19.2"
		}
		name:      "cert-manager-startupapicheck"
		namespace: "cert-manager"
	}
	spec: {
		backoffLimit: 4
		template: {
			metadata: labels: {
				app:                            "startupapicheck"
				"app.kubernetes.io/component":  "startupapicheck"
				"app.kubernetes.io/instance":   "cert-manager"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "startupapicheck"
				"app.kubernetes.io/version":    "v1.19.2"
				"helm.sh/chart":                "cert-manager-v1.19.2"
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					args: [
						"check",
						"api",
						"--wait=1m",
						"-v",
					]
					env: [{
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/jetstack/cert-manager-startupapicheck:v1.19.2"
					imagePullPolicy: "IfNotPresent"
					name:            "cert-manager-startupapicheck"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
					}
					volumeMounts: [{
						mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
						name:      "serviceaccount-token"
						readOnly:  true
					}]
				}]
				enableServiceLinks: false
				nodeSelector: "kubernetes.io/os": "linux"
				priorityClassName: "system-cluster-critical"
				restartPolicy:     "OnFailure"
				securityContext: {
					runAsNonRoot: true
					seccompProfile: type: "RuntimeDefault"
				}
				serviceAccountName: "cert-manager-startupapicheck"
				volumes: [{
					name: "serviceaccount-token"
					projected: {
						defaultMode: 292
						sources: [{
							serviceAccountToken: {
								expirationSeconds: 3607
								path:              "token"
							}
						}, {
							configMap: {
								items: [{
									key:  "ca.crt"
									path: "ca.crt"
								}]
								name: "kube-root-ca.crt"
							}
						}, {
							downwardAPI: items: [{
								fieldRef: {
									apiVersion: "v1"
									fieldPath:  "metadata.namespace"
								}
								path: "namespace"
							}]
						}]
					}
				}]
			}
		}
	}
}
