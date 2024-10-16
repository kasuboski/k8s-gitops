package media

persistentvolumeclaim: overseerr: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "overseerr"
			"app.kubernetes.io/name": "overseerr"
		}
		name: "overseerr"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}