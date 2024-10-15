package media

persistentvolumeclaim: prowlarr: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "prowlarr"
			"app.kubernetes.io/name": "prowlarr"
		}
		name: "prowlarr"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}
