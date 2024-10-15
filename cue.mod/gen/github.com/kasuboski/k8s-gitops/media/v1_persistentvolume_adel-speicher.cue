package media

persistentvolume: "adel-speicher": {
	apiVersion: "v1"
	kind:       "PersistentVolume"
	metadata: name: "adel-speicher"
	spec: {
		accessModes: ["ReadWriteOnce"]
		capacity: storage: "100Gi"
		local: path: "/mnt/speicher"
		nodeAffinity: required: nodeSelectorTerms: [{
			matchExpressions: [{
				key:      "kubernetes.io/hostname"
				operator: "In"
				values: ["adel"]
			}]
		}]
		persistentVolumeReclaimPolicy: "Retain"
		storageClassName:              "local-storage"
		volumeMode:                    "Filesystem"
	}
}
