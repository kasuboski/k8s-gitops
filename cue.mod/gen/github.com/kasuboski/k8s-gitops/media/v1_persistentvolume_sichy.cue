package media

persistentvolume: sichy: {
	apiVersion: "v1"
	kind:       "PersistentVolume"
	metadata: name: "sichy"
	spec: {
		accessModes: ["ReadWriteMany"]
		capacity: storage: "1Mi"
		nfs: {
			path:   "/sichy"
			server: "100.91.81.36"
		}
		storageClassName: "manual"
	}
}
