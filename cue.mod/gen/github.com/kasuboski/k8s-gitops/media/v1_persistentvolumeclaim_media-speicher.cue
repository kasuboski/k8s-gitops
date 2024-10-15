package media

persistentvolumeclaim: "media-speicher": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: name: "media-speicher"
	spec: {
		accessModes: ["ReadWriteMany"]
		resources: requests: storage: "1Mi"
		storageClassName: "manual"
		volumeName:       "speicher"
	}
}
