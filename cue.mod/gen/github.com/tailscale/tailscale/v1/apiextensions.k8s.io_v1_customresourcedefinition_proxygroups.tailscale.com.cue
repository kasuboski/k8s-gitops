package v1

customresourcedefinition: "proxygroups.tailscale.com": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.17.0"
		name: "proxygroups.tailscale.com"
	}
	spec: {
		group: "tailscale.com"
		names: {
			kind:     "ProxyGroup"
			listKind: "ProxyGroupList"
			plural:   "proxygroups"
			shortNames: ["pg"]
			singular: "proxygroup"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				description: "Status of the deployed ProxyGroup resources."
				jsonPath:    ".status.conditions[?(@.type == \"ProxyGroupReady\")].reason"
				name:        "Status"
				type:        "string"
			}, {
				description: "URL of the kube-apiserver proxy advertised by the ProxyGroup devices, if any. Only applies to ProxyGroups of type kube-apiserver."
				jsonPath:    ".status.url"
				name:        "URL"
				type:        "string"
			}, {
				description: "ProxyGroup type."
				jsonPath:    ".spec.type"
				name:        "Type"
				type:        "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: """
					ProxyGroup defines a set of Tailscale devices that will act as proxies.
					Depending on spec.Type, it can be a group of egress, ingress, or kube-apiserver
					proxies. In addition to running a highly available set of proxies, ingress
					and egress ProxyGroups also allow for serving many annotated Services from a
					single set of proxies to minimise resource consumption.

					For ingress and egress, use the tailscale.com/proxy-group annotation on a
					Service to specify that the proxy should be implemented by a ProxyGroup
					instead of a single dedicated proxy.

					More info:
					* https://tailscale.com/kb/1438/kubernetes-operator-cluster-egress
					* https://tailscale.com/kb/1439/kubernetes-operator-cluster-ingress

					For kube-apiserver, the ProxyGroup is a standalone resource. Use the
					spec.kubeAPIServer field to configure options specific to the kube-apiserver
					ProxyGroup type.
					"""
				properties: {
					apiVersion: {
						description: """
	APIVersion defines the versioned schema of this representation of an object.
	Servers should convert recognized schemas to the latest internal value, and
	may reject unrecognized values.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	"""
						type: "string"
					}
					kind: {
						description: """
	Kind is a string value representing the REST resource this object represents.
	Servers may infer this from the endpoint the client submits requests to.
	Cannot be updated.
	In CamelCase.
	More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	"""
						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Spec describes the desired ProxyGroup instances."
						properties: {
							hostnamePrefix: {
								description: """
	HostnamePrefix is the hostname prefix to use for tailnet devices created
	by the ProxyGroup. Each device will have the integer number from its
	StatefulSet pod appended to this prefix to form the full hostname.
	HostnamePrefix can contain lower case letters, numbers and dashes, it
	must not start with a dash and must be between 1 and 62 characters long.
	"""
								pattern: "^[a-z0-9][a-z0-9-]{0,61}$"
								type:    "string"
							}
							kubeAPIServer: {
								description: """
	KubeAPIServer contains configuration specific to the kube-apiserver
	ProxyGroup type. This field is only used when Type is set to "kube-apiserver".
	"""
								properties: {
									hostname: {
										description: """
	Hostname is the hostname with which to expose the Kubernetes API server
	proxies. Must be a valid DNS label no longer than 63 characters. If not
	specified, the name of the ProxyGroup is used as the hostname. Must be
	unique across the whole tailnet.
	"""
										pattern: "^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$"
										type:    "string"
									}
									mode: {
										description: """
	Mode to run the API server proxy in. Supported modes are auth and noauth.
	In auth mode, requests from the tailnet proxied over to the Kubernetes
	API server are additionally impersonated using the sender's tailnet identity.
	If not specified, defaults to auth mode.
	"""
										enum: [
											"auth",
											"noauth",
										]
										type: "string"
									}
								}
								type: "object"
							}
							proxyClass: {
								description: """
	ProxyClass is the name of the ProxyClass custom resource that contains
	configuration options that should be applied to the resources created
	for this ProxyGroup. If unset, and there is no default ProxyClass
	configured, the operator will create resources with the default
	configuration.
	"""
								type: "string"
							}
							replicas: {
								description: """
	Replicas specifies how many replicas to create the StatefulSet with.
	Defaults to 2.
	"""
								format:  "int32"
								minimum: 0
								type:    "integer"
							}
							tags: {
								description: """
	Tags that the Tailscale devices will be tagged with. Defaults to [tag:k8s].
	If you specify custom tags here, make sure you also make the operator
	an owner of these tags.
	See  https://tailscale.com/kb/1236/kubernetes-operator/#setting-up-the-kubernetes-operator.
	Tags cannot be changed once a ProxyGroup device has been created.
	Tag values must be in form ^tag:[a-zA-Z][a-zA-Z0-9-]*$.
	"""
								items: {
									pattern: "^tag:[a-zA-Z][a-zA-Z0-9-]*$"
									type:    "string"
								}
								type: "array"
							}
							type: {
								description: """
	Type of the ProxyGroup proxies. Supported types are egress, ingress, and kube-apiserver.
	Type is immutable once a ProxyGroup is created.
	"""
								enum: [
									"egress",
									"ingress",
									"kube-apiserver",
								]
								type: "string"
								"x-kubernetes-validations": [{
									message: "ProxyGroup type is immutable"
									rule:    "self == oldSelf"
								}]
							}
						}
						required: ["type"]
						type: "object"
					}
					status: {
						description: """
	ProxyGroupStatus describes the status of the ProxyGroup resources. This is
	set and managed by the Tailscale operator.
	"""
						properties: {
							conditions: {
								description: """
	List of status conditions to indicate the status of the ProxyGroup
	resources. Known condition types include `ProxyGroupReady` and
	`ProxyGroupAvailable`.

	* `ProxyGroupReady` indicates all ProxyGroup resources are reconciled and
	  all expected conditions are true.
	* `ProxyGroupAvailable` indicates that at least one proxy is ready to
	  serve traffic.

	For ProxyGroups of type kube-apiserver, there are two additional conditions:

	* `KubeAPIServerProxyConfigured` indicates that at least one API server
	  proxy is configured and ready to serve traffic.
	* `KubeAPIServerProxyValid` indicates that spec.kubeAPIServer config is
	  valid.
	"""
								items: {
									description: "Condition contains details for one aspect of the current state of this API Resource."
									properties: {
										lastTransitionTime: {
											description: """
	lastTransitionTime is the last time the condition transitioned from one status to another.
	This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable.
	"""
											format: "date-time"
											type:   "string"
										}
										message: {
											description: """
	message is a human readable message indicating details about the transition.
	This may be an empty string.
	"""
											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: """
	observedGeneration represents the .metadata.generation that the condition was set based upon.
	For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
	with respect to the current state of the instance.
	"""
											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: """
	reason contains a programmatic identifier indicating the reason for the condition's last transition.
	Producers of specific condition types may define expected values and meanings for this field,
	and whether the values are considered a guaranteed API.
	The value should be a CamelCase string.
	This field may not be empty.
	"""
											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase."
											maxLength:   316
											pattern:     "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:        "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							devices: {
								description: "List of tailnet devices associated with the ProxyGroup StatefulSet."
								items: {
									properties: {
										hostname: {
											description: """
	Hostname is the fully qualified domain name of the device.
	If MagicDNS is enabled in your tailnet, it is the MagicDNS name of the
	node.
	"""
											type: "string"
										}
										staticEndpoints: {
											description: "StaticEndpoints are user configured, 'static' endpoints by which tailnet peers can reach this device."
											items: type: "string"
											type: "array"
										}
										tailnetIPs: {
											description: """
	TailnetIPs is the set of tailnet IP addresses (both IPv4 and IPv6)
	assigned to the device.
	"""
											items: type: "string"
											type: "array"
										}
									}
									required: ["hostname"]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": ["hostname"]
								"x-kubernetes-list-type": "map"
							}
							url: {
								description: """
	URL of the kube-apiserver proxy advertised by the ProxyGroup devices, if
	any. Only applies to ProxyGroups of type kube-apiserver.
	"""
								type: "string"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
