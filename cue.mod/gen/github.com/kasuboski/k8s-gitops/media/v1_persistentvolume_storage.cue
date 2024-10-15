package media

persistentvolume: storage: {
	apiVersion: "v1"
	kind:       "PersistentVolume"
	metadata: name: "storage"
	spec: {
		accessModes: ["ReadWriteMany"]
		capacity: storage: "1Mi"
		nfs: {
			path:   "/storage"
			server: "fettig.lan"
		}
		nodeAffinity: required: nodeSelectorTerms: [{
			matchExpressions: [{
				key:      "topology.kubernetes.io/region"
				operator: "In"
				values: ["home"]
			}, {
				key:      "topology.kubernetes.io/zone"
				operator: "In"
				values: ["austin"]
			}]
		}]
		storageClassName: "manual"
	}
}
