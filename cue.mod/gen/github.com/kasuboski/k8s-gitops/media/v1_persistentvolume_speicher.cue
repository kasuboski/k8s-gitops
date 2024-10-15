package media

persistentvolume: speicher: {
	apiVersion: "v1"
	kind:       "PersistentVolume"
	metadata: name: "speicher"
	spec: {
		accessModes: ["ReadWriteMany"]
		capacity: storage: "1Mi"
		nfs: {
			path:   "/speicher"
			server: "100.71.44.76"
		}
		storageClassName: "manual"
	}
}
