package media

persistentvolumeclaim: "media-sichy": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: name: "media-sichy"
	spec: {
		accessModes: ["ReadWriteMany"]
		resources: requests: storage: "1Mi"
		storageClassName: "manual"
		volumeName:       "sichy"
	}
}
