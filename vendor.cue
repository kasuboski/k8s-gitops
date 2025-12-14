package apps

#Download: source: string

#Kustomize: path: string

#Helm: {
	// Chart reference - supports OCI (oci://...), traditional repos, local paths, URLs
	chart: string

	// Release name used in helm template command
	releaseName: string

	// Optional: chart version (e.g., "1.2.3", "^2.0.0", ">= 1.0.0")
	version?: string

	// Optional: repository URL for traditional Helm repos (e.g., "https://...")
	// Required when chart is in format "reponame/chartname"
	repo?: string

	// Optional: inline Helm values as CUE structures
	// Values will be marshaled to YAML for helm template
	values?: {...}

	// Optional: namespace for manifests (defaults to "default")
	namespace?: string

	// Optional: include CRDs in output (defaults to true)
	includeCRDs?: bool | *true

	// Optional: skip test manifests (defaults to true)
	skipTests?: bool | *true
}

#Upstream: {download: #Download} | {kustomize: #Kustomize} | {helm: #Helm}

#Vendor: {
	pkg: string
	#Upstream
}
vendor: [PKG=string]: #Vendor & {
	pkg: PKG
}
vendor: "github.com/envoyproxy/gateway/v1": download: source: "https://github.com/envoyproxy/gateway/releases/download/v1.1.2/install.yaml"

vendor: "github.com/DopplerHQ/kubernetes-operator/v1": download: source: "https://github.com/DopplerHQ/kubernetes-operator/releases/download/v1.5.1/recommended.yaml"
vendor: "github.com/longhorn/longhorn/v1": download: source:             "https://raw.githubusercontent.com/longhorn/longhorn/v1.10.1/deploy/longhorn.yaml"

vendor: "github.com/argoproj/argo-cd/josh": kustomize: path:                           "argocd"
vendor: "github.com/kasuboski/k8s-gitops/kubesystem": kustomize: path:                 "kube-system"
vendor: "github.com/kasuboski/k8s-gitops/descheduler": kustomize: path:                "descheduler"
vendor: "github.com/metallb/metallb": kustomize: path:                                 "networking/metallb"
vendor: "github.com/pl4nty/cloudflare-kubernetes-gateway/cloudflare": kustomize: path: "github.com/pl4nty/cloudflare-kubernetes-gateway//config/default?ref=v0.7.0"

// Example: Helm chart vendor (metrics-server from traditional repo)
// vendor: "test/metrics-server/v1": helm: {
// 	chart:       "metrics-server"
// 	releaseName: "metrics-server"
// 	repo:        "https://kubernetes-sigs.github.io/metrics-server/"
// 	version:     "3.11.0"
// 	namespace:   "kube-system"
// }

vendor: "github.com/victoriametrics/victoria-metrics-k8s-stack/v1": helm: {
	chart:       "oci://ghcr.io/victoriametrics/helm-charts/victoria-metrics-k8s-stack"
	version:     "0.65.1"
	releaseName: "vmks"
	namespace:   "victoria-metrics"
	values: {
		global: cluster: dnsDomain: "cluster.local"
		"victoria-metrics-operator": {
			annotations: "argocd.argoproj.io/sync-options": "SkipDryRunOnMissingResource=true"
			admissionWebhooks: {
				enabled:       true
				policy:        "Fail"
				keepTLSSecret: false
				certManager: {
					enabled: true
					cert: {
						duration:    "2160h" // 90 days
						renewBefore: "360h"  // 15 days
					}
				}
			}
		}
		alertmanager: enabled: false
		grafana: admin: existingSecret: "grafana"
		vmalert: enabled: false
		vmauth: enabled:  false
		vmagent: {
			route: {
				enabled: true
				parentRefs: [
					{
						name:      "http"
						namespace: "envoy-gateway-system"
					},
				]
				hostnames: ["vmagent.joshcorp.co"]
			}
		}
		kubeControllerManager: vmScrape: spec: endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			port:            "http-metrics"
			scheme:          "https"
			tlsConfig: {
				caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
				serverName:         "localhost"
				insecureSkipVerify: true
			}
		}]
		kubeScheduler: vmScrape: spec: endpoints: [{
			bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
			port:            "http-metrics"
			scheme:          "https"
			tlsConfig: {
				caFile:             "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
				serverName:         "127.0.0.1"
				insecureSkipVerify: true
			}
		}]
		kubeEctd: enabled: false
	}
}

vendor: "github.com/cert-manager/cert-manager/v1": helm: {
	chart:       "oci://quay.io/jetstack/charts/cert-manager"
	version:     "1.19.2"
	releaseName: "cert-manager"
	namespace:   "cert-manager"
	values: {
		crds: enabled: true
		global: priorityClassName: "system-cluster-critical"
		replicaCount: 2
		podDisruptionBudget: {
			enabled:     true
			minAvailable: 1
		}
		automountServiceAccountToken: false
		serviceAccount: automountServiceAccountToken: false
		volumes: [{
			name: "serviceaccount-token"
			projected: {
				defaultMode: 292
				sources: [
					{
						serviceAccountToken: {
							expirationSeconds: 3607
							path:              "token"
						}
					},
					{
						configMap: {
							name: "kube-root-ca.crt"
							items: [{
								key:  "ca.crt"
								path: "ca.crt"
							}]
						}
					},
					{
						downwardAPI: items: [{
							path: "namespace"
							fieldRef: {
								apiVersion: "v1"
								fieldPath:  "metadata.namespace"
							}
						}]
					},
				]
			}
		}]
		volumeMounts: [{
			mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
			name:      "serviceaccount-token"
			readOnly:  true
		}]
		webhook: {
			replicaCount: 3
			podDisruptionBudget: {
				enabled:     true
				minAvailable: 1
			}
			automountServiceAccountToken: false
			serviceAccount: automountServiceAccountToken: false
			volumes: [{
				name: "serviceaccount-token"
				projected: {
					defaultMode: 292
					sources: [
						{
							serviceAccountToken: {
								expirationSeconds: 3607
								path:              "token"
							}
						},
						{
							configMap: {
								name: "kube-root-ca.crt"
								items: [{
									key:  "ca.crt"
									path: "ca.crt"
								}]
							}
						},
						{
							downwardAPI: items: [{
								path: "namespace"
								fieldRef: {
									apiVersion: "v1"
									fieldPath:  "metadata.namespace"
								}
							}]
						},
					]
				}
			}]
			volumeMounts: [{
				mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
				name:      "serviceaccount-token"
				readOnly:  true
			}]
		}
		cainjector: {
			extraArgs: [
				"--enable-certificates-data-source=true",
			]
			replicaCount: 2
			podDisruptionBudget: {
				enabled:     true
				minAvailable: 1
			}
			automountServiceAccountToken: false
			serviceAccount: automountServiceAccountToken: false
			volumes: [{
				name: "serviceaccount-token"
				projected: {
					defaultMode: 292
					sources: [
						{
							serviceAccountToken: {
								expirationSeconds: 3607
								path:              "token"
							}
						},
						{
							configMap: {
								name: "kube-root-ca.crt"
								items: [{
									key:  "ca.crt"
									path: "ca.crt"
								}]
							}
						},
						{
							downwardAPI: items: [{
								path: "namespace"
								fieldRef: {
									apiVersion: "v1"
									fieldPath:  "metadata.namespace"
								}
							}]
						},
					]
				}
			}]
			volumeMounts: [{
				mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
				name:      "serviceaccount-token"
				readOnly:  true
			}]
		}
		startupapicheck: {
			automountServiceAccountToken: false
			serviceAccount: automountServiceAccountToken: false
			volumes: [{
				name: "serviceaccount-token"
				projected: {
					defaultMode: 292
					sources: [
						{
							serviceAccountToken: {
								expirationSeconds: 3607
								path:              "token"
							}
						},
						{
							configMap: {
								name: "kube-root-ca.crt"
								items: [{
									key:  "ca.crt"
									path: "ca.crt"
								}]
							}
						},
						{
							downwardAPI: items: [{
								path: "namespace"
								fieldRef: {
									apiVersion: "v1"
									fieldPath:  "metadata.namespace"
								}
							}]
						},
					]
				}
			}]
			volumeMounts: [{
				mountPath: "/var/run/secrets/kubernetes.io/serviceaccount"
				name:      "serviceaccount-token"
				readOnly:  true
			}]
		}
	}
}

vendorList: [...#Vendor]
vendorList: [for _, v in vendor {v}]
