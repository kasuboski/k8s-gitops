package media

persistentvolumeclaim: lidarr: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "lidarr"
			"app.kubernetes.io/name": "lidarr"
		}
		name: "lidarr"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}
