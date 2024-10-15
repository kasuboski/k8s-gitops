package media

persistentvolumeclaim: "media-storage": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: name: "media-storage"
	spec: {
		accessModes: ["ReadWriteMany"]
		resources: requests: storage: "1Mi"
		storageClassName: "manual"
		volumeName:       "storage"
	}
}
