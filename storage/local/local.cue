package local

storageclass: "local-storage": {
  provisioner: "kubernetes.io/no-provisioner"
  volumeBindingMode: "WaitForFirstConsumer"
}

persistentvolume: "adel-speicher": {
  spec: {
    capacity: storage: "100Gi"
    volumeMode: "Filesystem"
    accessModes: ["ReadWriteOnce"]
    persistentVolumeReclaimPolicy: "Retain"
    storageClassName: "local-storage"
    local: path: "/mnt/speicher"
    nodeAffinity: required: nodeSelectorTerms: [
      {
        matchExpressions: [{
          key: "kubernetes.io/hostname"
          operator: "In"
          values: ["adel"]
      }]
      }
    ]
  }
}

persistentvolume: storage: {
  spec: {
    storageClassName: "manual"
    capacity: storage: "1Mi"
    accessModes: ["ReadWriteOnce"]
    nfs: {
      server: "fettig.lan"
      path: "/storage"
    }
    nodeAffinity: required: nodeSelectorTerms: [
      {
        matchExpressions: [{
          key: "topology.kubernetes.io/region"
          operator: "In"
          values: ["home"]
        },
        {
          key: "topology.kubernetes.io/zone"
          operator: "In"
          values: ["austin"]
        }]
      }
    ]
  }
}