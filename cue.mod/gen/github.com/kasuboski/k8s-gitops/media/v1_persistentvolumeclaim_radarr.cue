package media

persistentvolumeclaim: radarr: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "radarr"
			"app.kubernetes.io/name": "radarr"
		}
		name: "radarr"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}
