package metallb

customresourcedefinition: "communities.metallb.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.14.0"
		name: "communities.metallb.io"
	}
	spec: {
		group: "metallb.io"
		names: {
			kind:     "Community"
			listKind: "CommunityList"
			plural:   "communities"
			singular: "community"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: """
					Community is a collection of aliases for communities.
					Users can define named aliases to be used in the BGPPeer CRD.
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
						description: "CommunitySpec defines the desired state of Community."
						properties: communities: {
							items: {
								properties: {
									name: {
										description: "The name of the alias for the community."
										type:        "string"
									}
									value: {
										description: """
	The BGP community value corresponding to the given name. Can be a standard community of the form 1234:1234
	or a large community of the form large:1234:1234:1234.
	"""
										type: "string"
									}
								}
								type: "object"
							}
							type: "array"
						}
						type: "object"
					}
					status: {
						description: "CommunityStatus defines the observed state of Community."
						type:        "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}