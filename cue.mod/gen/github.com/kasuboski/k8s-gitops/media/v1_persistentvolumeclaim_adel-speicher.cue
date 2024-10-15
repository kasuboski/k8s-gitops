package media

persistentvolumeclaim: "adel-speicher": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: name: "adel-speicher"
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Gi"
		storageClassName: "local-storage"
		volumeName:       "adel-speicher"
	}
}
