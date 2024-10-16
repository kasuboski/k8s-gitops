package media

daemonset: "intel-gpu-plugin": {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: {
		labels: app: "intel-gpu-plugin"
		name: "intel-gpu-plugin"
	}
	spec: {
		selector: matchLabels: app: "intel-gpu-plugin"
		template: {
			metadata: labels: app: "intel-gpu-plugin"
			spec: {
				containers: [{
					env: [{
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}]
					image:           "intel/intel-gpu-plugin:0.24.0"
					imagePullPolicy: "IfNotPresent"
					name:            "intel-gpu-plugin"
					securityContext: {
						allowPrivilegeEscalation: false
						readOnlyRootFilesystem:   true
					}
					volumeMounts: [{
						mountPath: "/dev/dri"
						name:      "devfs"
						readOnly:  true
					}, {
						mountPath: "/sys/class/drm"
						name:      "sysfs"
						readOnly:  true
					}, {
						mountPath: "/var/lib/kubelet/device-plugins"
						name:      "kubeletsockets"
					}]
				}]
				initContainers: [{
					image:           "intel/intel-gpu-initcontainer:0.24.0"
					imagePullPolicy: "IfNotPresent"
					name:            "intel-gpu-initcontainer"
					securityContext: {
						allowPrivilegeEscalation: false
						readOnlyRootFilesystem:   true
					}
					volumeMounts: [{
						mountPath: "/etc/kubernetes/node-feature-discovery/source.d/"
						name:      "nfd-source-hooks"
					}]
				}]
				nodeSelector: {
					"kubernetes.io/arch":     "amd64"
					"kubernetes.io/hostname": "adel"
				}
				volumes: [{
					hostPath: path: "/dev/dri"
					name: "devfs"
				}, {
					hostPath: path: "/sys/class/drm"
					name: "sysfs"
				}, {
					hostPath: path: "/var/lib/kubelet/device-plugins"
					name: "kubeletsockets"
				}, {
					hostPath: {
						path: "/etc/kubernetes/node-feature-discovery/source.d/"
						type: "DirectoryOrCreate"
					}
					name: "nfd-source-hooks"
				}]
			}
		}
	}
}