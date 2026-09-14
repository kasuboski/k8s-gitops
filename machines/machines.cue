package machines

import (
	talos "github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
)

// Patch is a strategic merge patch for Talos config
// We reference Talos types for validation but all fields are optional
#Patch: {
	machine?: {
		kubelet?: talos.#KubeletConfig
		network?: talos.#NetworkConfig
		install?: talos.#InstallConfig
		// nodeLabels can be string values or patch directives like {$patch: "delete"}
		nodeLabels?: {[string]: string | {$patch: string}}
		...
	}
	cluster?: {
		etcd?: talos.#EtcdConfig
		...
	}
	// Allow other top-level fields for things like VolumeConfig
	...
}

// Cluster-wide patches - applied to all nodes
commonPatches: {
	kubeletCert: #Patch & {
		machine: kubelet: extraArgs: "rotate-server-certificates": "true"
	}

	kubeletIP: #Patch & {
		machine: kubelet: nodeIP: validSubnets: [
			"0.0.0.0/0",
		]
	}

	austinLabels: #Patch & {
		machine: nodeLabels: {
			"topology.kubernetes.io/region": "home"
			"topology.kubernetes.io/zone":   "austin"
		}
	}
}

// KubeSpan configuration - enables secure WireGuard mesh networking
kubespanEnabled: #Patch & {
	machine: network: kubespan: {
		enabled: true
	}
	cluster: discovery: {
		enabled: true
		registries: {
			kubernetes: disabled: true // Recommended with KubeSpan
			service: {} // Use Sidero Labs discovery service
		}
	}
}

// Control plane certificate SANs - for DNS-based API access
apiServerCertSANs: #Patch & {
	machine: certSANs: [
		"k8s-api.joshcorp.co",
		"adel",
		"adel.lan",
	]
}

// Control plane scheduling - for single control plane clusters
// Allows workloads to run on control plane and enables load balancer integration
controlPlaneScheduling: #Patch & {
	cluster: allowSchedulingOnControlPlanes: true
	// Remove the load balancer exclusion label so MetalLB can use control plane
	machine: nodeLabels: "node.kubernetes.io/exclude-from-external-load-balancers": {
		$patch: "delete"
	}
}

// Control plane metrics - expose controller manager and scheduler on 0.0.0.0
controlPlaneMetrics: #Patch & {
	cluster: {
		controllerManager: extraArgs: "bind-address": "0.0.0.0"
		scheduler: extraArgs: "bind-address":          "0.0.0.0"
	}
}

// Image Factory installer image for x86 nodes with extensions
x86InstallerImage: #Patch & {
	machine: install: image: "factory.talos.dev/installer/\(cluster.talos.schematics.x86):\(cluster.talos.version)"
}

// Per-node patches
nodePatches: {
	adel: #Patch & {
		machine: {
			install: {
				disk: "/dev/sda"
				wipe: true
			}
			network: hostname: "adel"
		}
	}
}

// Node definition schema
#Node: {
	role: "controlplane" | "worker"
	patches: [...#Patch]
}

// Node definitions with their patch lists
nodes: {
	// adel - x86 control plane node (single control plane, no HA)
	adel: #Node & {
		role: "controlplane"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			kubespanEnabled,
			apiServerCertSANs,
			controlPlaneScheduling,
			controlPlaneMetrics,
			x86InstallerImage,
			longhornPatches.ephemeralVolume,
			longhornPatches.kubeletMounts,
			longhornPatches.v2DataEngine,
			longhornPatches.sataVolume,
			nodePatches.adel, // Contains /dev/sda disk config
		]
	}
}
