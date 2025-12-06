package v1

import "encoding/yaml"

namespace: "doppler-operator-system": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		labels: "control-plane": "controller-manager"
		name: "doppler-operator-system"
	}
}
customresourcedefinition: "dopplersecrets.secrets.doppler.com": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		creationTimestamp: null
		name:              "dopplersecrets.secrets.doppler.com"
	}
	spec: {
		group: "secrets.doppler.com"
		names: {
			kind:     "DopplerSecret"
			listKind: "DopplerSecretList"
			plural:   "dopplersecrets"
			singular: "dopplersecret"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "DopplerSecret is the Schema for the dopplersecrets API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "DopplerSecretSpec defines the desired state of DopplerSecret"
						properties: {
							config: {
								description: "The Doppler config"
								type:        "string"
							}
							format: {
								description: "Format enables the downloading of secrets as a file"
								enum: [
									"json",
									"dotnet-json",
									"env",
									"yaml",
									"docker",
								]
								type: "string"
							}
							host: {
								default:     "https://api.doppler.com"
								description: "The Doppler API host"
								type:        "string"
							}
							managedSecret: {
								description: "The Kubernetes secret where the operator will store and sync the fetched secrets"
								properties: {
									name: {
										description: "The name of the Secret resource"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the resource being referred to. Ignored if not cluster scoped"
										type:        "string"
									}
									type: {
										default:     "Opaque"
										description: "The secret type of the managed secret"
										enum: [
											"Opaque",
											"kubernetes.io/tls",
											"kubernetes.io/service-account-token",
											"kubernetes.io/dockercfg",
											"kubernetes.io/dockerconfigjson",
											"kubernetes.io/basic-auth",
											"kubernetes.io/ssh-auth",
											"bootstrap.kubernetes.io/token",
										]
										type: "string"
									}
								}
								required: ["name"]
								type: "object"
							}
							nameTransformer: {
								description: "The environment variable compatible secrets name transformer to apply"
								enum: [
									"upper-camel",
									"camel",
									"lower-snake",
									"tf-var",
									"dotnet-env",
									"lower-kebab",
								]
								type: "string"
							}
							processors: {
								additionalProperties: {
									properties: {
										asName: {
											description: "The mapped name of the field in the managed secret, defaults to the original Doppler secret name for Opaque Kubernetes secrets. If omitted for other types, the value is not copied to the managed secret."
											type:        "string"
										}
										type: {
											default:     "plain"
											description: "The type of process to be performed, either \"plain\" or \"base64\""
											enum: [
												"plain",
												"base64",
											]
											type: "string"
										}
									}
									type: "object"
								}
								description: "A list of processors to transform the data during ingestion"
								type:        "object"
							}
							project: {
								description: "The Doppler project"
								type:        "string"
							}
							resyncSeconds: {
								default:     60
								description: "The number of seconds to wait between resyncs"
								format:      "int64"
								type:        "integer"
							}
							secrets: {
								description: "A list of secrets to sync from the config"
								items: type: "string"
								type: "array"
							}
							tokenSecret: {
								description: "The Kubernetes secret containing the Doppler service token"
								properties: {
									name: {
										description: "The name of the Secret resource"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the resource being referred to. Ignored if not cluster scoped"
										type:        "string"
									}
								}
								required: ["name"]
								type: "object"
							}
							verifyTLS: {
								default:     true
								description: "Whether or not to verify TLS"
								type:        "boolean"
							}
						}
						type: "object"
					}
					status: {
						description: "DopplerSecretStatus defines the observed state of DopplerSecret"
						properties: conditions: {
							items: {
								description: """
	Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: "Available", "Progressing", and "Degraded"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:"conditions,omitempty" patchStrategy:"merge" patchMergeKey:"type" protobuf:"bytes,1,rep,name=conditions"` 
	     // other fields }
	"""
								properties: {
									lastTransitionTime: {
										description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
										format:      "date-time"
										type:        "string"
									}
									message: {
										description: "message is a human readable message indicating details about the transition. This may be an empty string."
										maxLength:   32768
										type:        "string"
									}
									observedGeneration: {
										description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
										format:      "int64"
										minimum:     0
										type:        "integer"
									}
									reason: {
										description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
										maxLength:   1024
										minLength:   1
										pattern:     "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
										type:        "string"
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
										description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
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
						}
						required: ["conditions"]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}
serviceaccount: "doppler-operator-controller-manager": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "doppler-operator-controller-manager"
		namespace: "doppler-operator-system"
	}
}
role: "doppler-operator-leader-election-role": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name:      "doppler-operator-leader-election-role"
		namespace: "doppler-operator-system"
	}
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}
clusterrole: "doppler-operator-manager-role": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		creationTimestamp: null
		name:              "doppler-operator-manager-role"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: [
			"get",
			"list",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["secrets.doppler.com"]
		resources: ["dopplersecrets"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["secrets.doppler.com"]
		resources: ["dopplersecrets/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["secrets.doppler.com"]
		resources: ["dopplersecrets/status"]
		verbs: [
			"get",
			"patch",
			"update",
		]
	}]
}
rolebinding: "doppler-operator-leader-election-rolebinding": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name:      "doppler-operator-leader-election-rolebinding"
		namespace: "doppler-operator-system"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "doppler-operator-leader-election-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "doppler-operator-controller-manager"
		namespace: "doppler-operator-system"
	}]
}
clusterrolebinding: "doppler-operator-manager-rolebinding": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "doppler-operator-manager-rolebinding"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "doppler-operator-manager-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "doppler-operator-controller-manager"
		namespace: "doppler-operator-system"
	}]
}
configmap: "doppler-operator-manager-config": {
	apiVersion: "v1"
	data: {
		"controller_manager_config.yaml": yaml.Marshal(_cue_controller_manager_config_yaml)
		let _cue_controller_manager_config_yaml = {
			apiVersion: "controller-runtime.sigs.k8s.io/v1alpha1"
			kind:       "ControllerManagerConfig"
			health: healthProbeBindAddress: ":8081"
			metrics: bindAddress: "127.0.0.1:8080"
			webhook: port: 9443
			leaderElection: {
				leaderElect:  true
				resourceName: "f39fa519.doppler.com"
			}
		}, }
	kind: "ConfigMap"
	metadata: {
		name:      "doppler-operator-manager-config"
		namespace: "doppler-operator-system"
	}
}
deployment: "doppler-operator-controller-manager": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: "control-plane": "controller-manager"
		name:      "doppler-operator-controller-manager"
		namespace: "doppler-operator-system"
	}
	spec: {
		replicas: 1
		selector: matchLabels: "control-plane": "controller-manager"
		template: {
			metadata: labels: "control-plane": "controller-manager"
			spec: {
				containers: [{
					args: [
						"--health-probe-bind-address=:8081",
						"--metrics-bind-address=127.0.0.1:8080",
						"--leader-elect",
					]
					command: ["/manager"]
					image: "dopplerhq/kubernetes-operator:1.5.1"
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: 8081
						}
						initialDelaySeconds: 15
						periodSeconds:       20
					}
					name: "manager"
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 8081
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					resources: {
						limits: {
							cpu:    "100m"
							memory: "256Mi"
						}
						requests: {
							cpu:    "100m"
							memory: "256Mi"
						}
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["NET_RAW"]
						privileged:   false
						runAsNonRoot: true
					}
				}]
				securityContext: runAsNonRoot: true
				serviceAccountName:            "doppler-operator-controller-manager"
				terminationGracePeriodSeconds: 10
			}
		}
	}
}
