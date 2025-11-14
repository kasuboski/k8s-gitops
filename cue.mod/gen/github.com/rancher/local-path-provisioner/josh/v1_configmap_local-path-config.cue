package josh

import (
	json656e63 "encoding/json"
	yaml656e63 "encoding/yaml"
)

configmap: "local-path-config": {
	apiVersion: "v1"
	data: {
		"config.json": json656e63.Marshal(_cue_config_json)
		let _cue_config_json = {
			nodePathMap: [
				{
					node: "DEFAULT_PATH_FOR_NON_LISTED_NODES"
					paths: ["/var/local-path-provisioner"]
				},
			]
		}
		"helperPod.yaml": yaml656e63.Marshal(_cue_helperPod_yaml)
		let _cue_helperPod_yaml = {
			apiVersion: "v1"
			kind:       "Pod"
			metadata: name: "helper-pod"
			spec: {
				priorityClassName: "system-node-critical"
				tolerations: [{
					key:      "node.kubernetes.io/disk-pressure"
					operator: "Exists"
					effect:   "NoSchedule"
				}]
				containers: [{
					name:            "helper-pod"
					image:           "busybox"
					imagePullPolicy: "IfNotPresent"
				}]
			}
		}
		setup: """
			#!/bin/sh
			set -eu
			mkdir -m 0777 -p "$VOL_DIR"
			"""
		teardown: """
			#!/bin/sh
			set -eu
			rm -rf "$VOL_DIR"
			"""
	}
	kind: "ConfigMap"
	metadata: {
		name:      "local-path-config"
		namespace: "local-path-storage"
	}
}
