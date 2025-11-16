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
			"!100.64.0.0/10", // ignore tailscale
		]
	}

	austinLabels: #Patch & {
		machine: nodeLabels: {
			"topology.kubernetes.io/region": "home"
			"topology.kubernetes.io/zone":   "austin"
		}
	}
}

// Control plane specific patches
controlPlanePatches: {
	vip: #Patch & {
		machine: network: interfaces: [{
			deviceSelector: physical: true
			dhcp: true
			vip: ip: "192.168.86.19"
		}]
	}

	etcdAdvertise: #Patch & {
		cluster: etcd: advertisedSubnets: [
			"0.0.0.0/0",
			"!100.64.0.0/10", // ignore tailscale
		]
	}

	ephemeralUSB: {
		apiVersion: "v1alpha1"
		kind:       "VolumeConfig"
		name:       "EPHEMERAL"
		provisioning: {
			diskSelector: match: "disk.transport == 'usb'"
			minSize: "2GB"
		}
	}

	sdcardInstall: #Patch & {
		machine: install: disk: "/dev/mmcblk0"
	}
}

// Worker specific patches
workerPatches: {
	sdcardInstall: #Patch & {
		machine: install: disk: "/dev/mmcblk0"
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
	cherry: #Node & {
		role: "controlplane"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			controlPlanePatches.vip,
			controlPlanePatches.etcdAdvertise,
			controlPlanePatches.ephemeralUSB,
			controlPlanePatches.sdcardInstall,
			nodePatches.cherry,
		]
	}

	blueberry: #Node & {
		role: "controlplane"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			controlPlanePatches.vip,
			controlPlanePatches.etcdAdvertise,
			controlPlanePatches.ephemeralUSB,
			controlPlanePatches.sdcardInstall,
			nodePatches.blueberry,
		]
	}

	pumpkin: #Node & {
		role: "controlplane"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			controlPlanePatches.vip,
			controlPlanePatches.etcdAdvertise,
			controlPlanePatches.ephemeralUSB,
			controlPlanePatches.sdcardInstall,
			nodePatches.pumpkin,
		]
	}

	apple: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			workerPatches.sdcardInstall,
			nodePatches.apple,
		]
	}

	adel: #Node & {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			nodePatches.adel,
		]
	}
}
