package media

persistentvolumeclaim: sabnzbd: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:                      "sabnzbd"
			"app.kubernetes.io/name": "sabnzbd"
		}
		name: "sabnzbd"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "100Mi"
		storageClassName: "local-path"
	}
}
