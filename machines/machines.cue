package machines

import (
	talos "github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
)

// Patch is a strategic merge patch for Talos config
// We reference Talos types for validation but all fields are optional
#Patch: {
	machine?: {
		kubelet?:     talos.#KubeletConfig
		network?:     talos.#NetworkConfig
		install?:     talos.#InstallConfig
		nodeLabels?:  {[string]: string}
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
			service: {}                // Use Sidero Labs discovery service
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

// Hardware-specific patches
hardwarePatches: {
	// SD card install for Raspberry Pi nodes
	sdcardInstall: #Patch & {
		machine: install: disk: "/dev/mmcblk0"
	}

	// USB ephemeral storage (only for RPi nodes with USB drives)
	ephemeralUSB: {
		apiVersion: "v1alpha1"
		kind:       "VolumeConfig"
		name:       "EPHEMERAL"
		provisioning: {
			diskSelector: match: "disk.transport == 'usb'"
			minSize: "2GB"
		}
	}
}

// Per-node patches
nodePatches: {
	cherry: #Patch & {
		machine: network: hostname: "cherry"
	}

	blueberry: #Patch & {
		machine: network: hostname: "blueberry"
	}

	pumpkin: #Patch & {
		machine: network: hostname: "pumpkin"
	}

	apple: #Patch & {
		machine: network: hostname: "apple"
	}

	adel: #Patch & {
		machine: {
			install: {
				disk: "/dev/sdb"
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
			nodePatches.adel, // Contains /dev/sdb disk config
		]
	}

	// cherry - Raspberry Pi worker with USB ephemeral storage
	cherry: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			kubespanEnabled,
			hardwarePatches.sdcardInstall,
			hardwarePatches.ephemeralUSB,
			nodePatches.cherry,
		]
	}

	// blueberry - Raspberry Pi worker with USB ephemeral storage
	blueberry: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			kubespanEnabled,
			hardwarePatches.sdcardInstall,
			hardwarePatches.ephemeralUSB,
			nodePatches.blueberry,
		]
	}

	// pumpkin - Raspberry Pi worker with USB ephemeral storage
	pumpkin: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			kubespanEnabled,
			hardwarePatches.sdcardInstall,
			hardwarePatches.ephemeralUSB,
			nodePatches.pumpkin,
		]
	}

	// apple - Raspberry Pi worker (SD card only, no USB)
	apple: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			kubespanEnabled,
			hardwarePatches.sdcardInstall,
			nodePatches.apple,
		]
	}
}
