package machines

// Longhorn storage patches - required for persistent storage
longhornPatches: {
	// Base ephemeral volume configuration
	// EPHEMERAL volume must be fixed size to leave room for Longhorn UserVolumeConfig
	// EPHEMERAL contains /var: container data, images, logs, etcd
	// NOTE: Cannot be expanded after initial provisioning - size generously!
	_ephemeralBase: {
		apiVersion: "v1alpha1"
		kind:       "VolumeConfig"
		name:       "EPHEMERAL"
		provisioning: {
			minSize: "2GB"
			maxSize: "80GB" // Generous for images, etcd, logs - cannot expand later!
			grow:    false
		}
	}

	// x86 ephemeral volume on system disk
	ephemeralVolume: _ephemeralBase & {
		provisioning: diskSelector: match: "system_disk"
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

	// SATA Longhorn volume - uses all remaining space on SATA disk after EPHEMERAL
	sataVolume: {
		apiVersion: "v1alpha1"
		kind:       "UserVolumeConfig"
		name:       "longhorn"
		provisioning: {
			diskSelector: match: "disk.transport == 'sata'"
			minSize: "10GB" // Minimum required, will grow to fill remaining space
		}
	}

	// NVMe Longhorn volume - uses all remaining space on NVMe disk after EPHEMERAL
	nvmeVolume: {
		apiVersion: "v1alpha1"
		kind:       "UserVolumeConfig"
		name:       "longhorn"
		provisioning: {
			diskSelector: match: "disk.transport == 'nvme'"
			minSize: "10GB" // Minimum required, will grow to fill remaining space
		}
	}

	// Raspberry Pi ephemeral volume on USB
	rpiEphemeralUSB: _ephemeralBase & {
		provisioning: diskSelector: match: "disk.transport == 'usb'"
	}

	// USB Longhorn volume for Raspberry Pi - uses remaining space on USB drive after EPHEMERAL
	usbVolume: {
		apiVersion: "v1alpha1"
		kind:       "UserVolumeConfig"
		name:       "longhorn"
		provisioning: {
			diskSelector: match: "disk.transport == 'usb'"
			minSize: "10GB" // Minimum required, will grow to fill remaining space
		}
	}
}
