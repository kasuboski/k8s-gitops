package lb

ipaddresspool: "austin-ips": {
	apiVersion: "metallb.io/v1beta1"
	kind:       "IPAddressPool"
	metadata: name: "austin-ips"
	spec: addresses: ["192.168.86.243-192.168.86.250"]
}

l2advertisement: "austin-advertisement": {
	apiVersion: "metallb.io/v1beta1"
	kind:       "L2Advertisement"
	metadata: name: "austin-advertisement"
	spec: {
		ipAddressPools: ["austin-ips"]
		nodeSelectors: [{
			matchLabels: "topology.kubernetes.io/zone": "austin"
		}]
	}
}

deployment: controller: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "controller"
	spec: template: spec: nodeSelector: "topology.kubernetes.io/zone": "austin"
}

daemonset: speaker: {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	metadata: name: "speaker"
	spec: template: spec: nodeSelector: "topology.kubernetes.io/zone": "austin"
}
