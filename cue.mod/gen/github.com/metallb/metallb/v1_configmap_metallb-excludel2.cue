package metallb

import yaml656e63 "encoding/yaml"

configmap: "metallb-excludel2": {
	apiVersion: "v1"
	data: {
		"excludel2.yaml": yaml656e63.Marshal(_cue_excludel2_yaml)
		let _cue_excludel2_yaml = {
			announcedInterfacesToExclude: ["^docker.*", "^cbr.*", "^dummy.*", "^virbr.*", "^lxcbr.*", "^veth.*", "^lo$", "^cali.*", "^tunl.*", "^flannel.*", "^kube-ipvs.*", "^cni.*", "^nodelocaldns.*"]}, }
	kind: "ConfigMap"
	metadata: {
		name:      "metallb-excludel2"
		namespace: "metallb-system"
	}
}
