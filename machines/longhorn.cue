package machines

// Longhorn storage patches - required for persistent storage on x86 nodes
longhornPatches: {
	// EPHEMERAL volume must be fixed size to leave room for Longhorn UserVolumeConfig
	// EPHEMERAL contains /var: container data, images, logs, etcd
	// NOTE: Cannot be expanded after initial provisioning - size generously!
	ephemeralVolume: {
		apiVersion: "v1alpha1"
		kind:       "VolumeConfig"
		name:       "EPHEMERAL"
		provisioning: {
			diskSelector: match: "system_disk" // Same as default
			minSize: "2GB"
			maxSize: "80GB" // Generous for images, etcd, logs - cannot expand later!
			grow:    false
		}
	}

	// Kubelet mounts for Longhorn (all nodes using Longhorn)
	// NOTE: Longhorn must be configured with defaultDataPath=/var/mnt/longhorn
	kubeletMounts: #Patch & {
		machine: kubelet: extraMounts: [{
			destination: "/var/mnt/longhorn"
			type:        "bind"
			source:      "/var/mnt/longhorn"
			options: ["bind", "rshared", "rw"]
		}]
	}

	// V2 Data Engine support
	v2DataEngine: #Patch & {
		machine: {
			sysctls: "vm.nr_hugepages": "1024"
			kernel: modules: [{
				name: "nvme_tcp"
			}, {
				name: "vfio_pci"
			}]
		}
	}

	// x86 Longhorn volume - uses all remaining space on SATA disk after EPHEMERAL
	x86Volume: {
		apiVersion: "v1alpha1"
		kind:       "UserVolumeConfig"
		name:       "longhorn"
		provisioning: {
			diskSelector: match: "disk.transport == 'sata'"
			minSize: "10GB" // Minimum required, will grow to fill remaining space
		}
	}
}
