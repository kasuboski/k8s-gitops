// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/coordination/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/api/coordination/v1"
)

// Lease defines a lease concept.
#Lease: {
	metav1.#TypeMeta

	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec contains the specification of the Lease.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #LeaseSpec @go(Spec) @protobuf(2,bytes,opt)
}

// LeaseSpec is a specification of a Lease.
#LeaseSpec: {
	// holderIdentity contains the identity of the holder of a current lease.
	// If Coordinated Leader Election is used, the holder identity must be
	// equal to the elected LeaseCandidate.metadata.name field.
	// +optional
	holderIdentity?: null | string @go(HolderIdentity,*string) @protobuf(1,bytes,opt)

	// leaseDurationSeconds is a duration that candidates for a lease need
	// to wait to force acquire it. This is measure against time of last
	// observed renewTime.
	// +optional
	leaseDurationSeconds?: null | int32 @go(LeaseDurationSeconds,*int32) @protobuf(2,varint,opt)

	// acquireTime is a time when the current lease was acquired.
	// +optional
	acquireTime?: null | metav1.#MicroTime @go(AcquireTime,*metav1.MicroTime) @protobuf(3,bytes,opt)

	// renewTime is a time when the current holder of a lease has last
	// updated the lease.
	// +optional
	renewTime?: null | metav1.#MicroTime @go(RenewTime,*metav1.MicroTime) @protobuf(4,bytes,opt)

	// leaseTransitions is the number of transitions of a lease between
	// holders.
	// +optional
	leaseTransitions?: null | int32 @go(LeaseTransitions,*int32) @protobuf(5,varint,opt)

	// Strategy indicates the strategy for picking the leader for coordinated leader election
	// (Alpha) Using this field requires the CoordinatedLeaderElection feature gate to be enabled.
	// +featureGate=CoordinatedLeaderElection
	// +optional
	strategy?: null | v1.#CoordinatedLeaseStrategy @go(Strategy,*v1.CoordinatedLeaseStrategy) @protobuf(6,bytes,opt)

	// PreferredHolder signals to a lease holder that the lease has a
	// more optimal holder and should be given up.
	// +featureGate=CoordinatedLeaderElection
	// +optional
	preferredHolder?: null | string @go(PreferredHolder,*string) @protobuf(7,bytes,opt)
}

// LeaseList is a list of Lease objects.
#LeaseList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is a list of schema objects.
	items: [...#Lease] @go(Items,[]Lease) @protobuf(2,bytes,rep)
}
