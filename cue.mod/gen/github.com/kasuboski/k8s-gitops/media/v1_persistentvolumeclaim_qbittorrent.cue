package media

persistentvolumeclaim: qbittorrent: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "qbittorrent"
			"app.kubernetes.io/name": "qbittorrent"
		}
		name: "qbittorrent"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}