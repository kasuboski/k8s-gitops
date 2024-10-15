package media

persistentvolumeclaim: sonarr: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "sonarr"
			"app.kubernetes.io/name": "sonarr"
		}
		name: "sonarr"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}
