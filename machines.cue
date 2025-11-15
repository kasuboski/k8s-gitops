package machines

// Cluster-wide patches - applied to all nodes
commonPatches: {
	kubeletCert: {
		machine: kubelet: extraArgs: "rotate-server-certificates": "true"
	}

	kubeletIP: {
		machine: kubelet: nodeIP: validSubnets: [
			"0.0.0.0/0",
			"!100.64.0.0/10", // ignore tailscale
		]
	}

	austinLabels: {
		machine: nodeLabels: {
			"topology.kubernetes.io/region": "home"
			"topology.kubernetes.io/zone":   "austin"
		}
	}
}

// Control plane specific patches
controlPlanePatches: {
	vip: {
		machine: network: interfaces: [{
			deviceSelector: physical: true
			dhcp: true
			vip: ip: "192.168.86.19"
		}]
	}

	etcdAdvertise: {
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

	sdcardInstall: {
		machine: install: disk: "/dev/mmcblk0"
	}
}

// Worker specific patches
workerPatches: {
	sdcardInstall: {
		machine: install: disk: "/dev/mmcblk0"
	}
}

// Per-node patches
nodePatches: {
	cherry: {
		machine: network: hostname: "cherry"
	}

	blueberry: {
		machine: network: hostname: "blueberry"
	}

	pumpkin: {
		machine: network: hostname: "pumpkin"
	}

	apple: {
		machine: network: hostname: "apple"
	}

	adel: {
		machine: {
			install: {
				disk: "/dev/sdb"
				wipe: true
			}
			network: hostname: "adel"
		}
	}
}

// Node definitions with their patch lists
nodes: {
	cherry: {
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

	blueberry: {
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

	pumpkin: {
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

	apple: {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			workerPatches.sdcardInstall,
			nodePatches.apple,
		]
	}

	adel: {
		role: "worker"
		patches: [
			commonPatches.kubeletCert,
			commonPatches.kubeletIP,
			commonPatches.austinLabels,
			nodePatches.adel,
		]
	}
}
