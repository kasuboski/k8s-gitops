package media

storageclass: "local-storage": {
	apiVersion: "storage.k8s.io/v1"
	kind:       "StorageClass"
	metadata: name: "local-storage"
	provisioner:       "kubernetes.io/no-provisioner"
	volumeBindingMode: "WaitForFirstConsumer"
}
