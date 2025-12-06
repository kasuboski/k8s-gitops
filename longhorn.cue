package apps

import (
	"encoding/yaml"
	"github.com/longhorn/longhorn/v1"
)

apps: longhorn: {
	namespace: "longhorn-system"
	// Start with v1 resources but exclude ones we're completely replacing
	resources: {
		// Include all v1 resources except configmap, deployment, and service
		for kind, items in v1
		if kind != "configmap" && kind != "deployment" && kind != "service" {
			(kind): items
		}

		// Include configmaps except the ones we're overriding completely
		configmap: {
			for name, item in v1.configmap
			if name != "longhorn-default-setting" && name != "longhorn-storageclass" {
				(name): item
			}
		}
		// Include all deployments from v1 except ones we're overriding
		deployment: {
			for name, item in v1.deployment
			if name != "longhorn-ui" {
				(name): item
			}
		}
		// Include all services except the one with nodePort: null issue
		service: {
			for name, item in v1.service
			if name != "longhorn-frontend" {
				(name): item
			}
		}
	}
	// Merge our custom overrides (this works for most fields)
	resources: _override

	resources: httproute: longhornui: {
		apiVersion: "gateway.networking.k8s.io/v1"
		kind:       "HTTPRoute"
		metadata: name:      "longhorn-ui"
		metadata: namespace: "longhorn-system"
		spec: {
			parentRefs: [
				{
					group:     "gateway.networking.k8s.io"
					kind:      "Gateway"
					name:      "http"
					namespace: "envoy-gateway-system"
				},
			]
			hostnames: [
				"longhorn.joshcorp.co",
			]
			rules: [
				{
					backendRefs: [
						{
							group:  ""
							kind:   "Service"
							name:   "longhorn-frontend"
							port:   80
							weight: 1
						},
					]
					matches: [
						{
							path: {
								type:  "PathPrefix"
								value: "/"
							}
						},
					]
				},
			]
		}
	}
}

_override: namespace: "longhorn-system": {
	metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"
}

// Fix service nodePort - v1 has null which conflicts with K8s schema
// Must completely redefine the service without nodePort field
_override: service: "longhorn-frontend": {
	let v1Svc = v1.service."longhorn-frontend"
	apiVersion: v1Svc.apiVersion
	kind:       v1Svc.kind
	metadata:   v1Svc.metadata
	spec: {
		selector: v1Svc.spec.selector
		type:     v1Svc.spec.type
		ports: [{
			name:       "http"
			port:       80
			targetPort: "http"
		},
			// Omit nodePort - v1 has nodePort: null which can't be marshaled to JSON
		]
	}
}

// Override default settings - merge our settings with v1 defaults
_override: configmap: "longhorn-default-setting": {
	metadata: namespace: "longhorn-system"
	data: {
		"default-setting.yaml": yaml.Marshal(_longhorn_settings)
		let _longhorn_settings = {
			// Preserve v1 defaults
			"priority-class":           "longhorn-critical"
			"disable-revision-counter": "{\"v1\":\"true\"}"

			// Add our custom settings
			"default-data-path":     "/var/mnt/longhorn"
			"default-replica-count": 1
		}, }
}

// Override storageclass settings - must redefine entire configmap to change let bindings
_override: configmap: "longhorn-storageclass": {
	metadata: namespace: "longhorn-system"
	data: {
		"storageclass.yaml": yaml.Marshal(_longhorn_storageclass)
		let _longhorn_storageclass = {
			kind:       "StorageClass"
			apiVersion: "storage.k8s.io/v1"
			metadata: {
				name: "longhorn"
				annotations: "storageclass.kubernetes.io/is-default-class": "true"
			}
			provisioner:          "driver.longhorn.io"
			allowVolumeExpansion: true
			reclaimPolicy:        "Delete"
			volumeBindingMode:    "WaitForFirstConsumer"
			parameters: {
				numberOfReplicas:          "1"
				staleReplicaTimeout:       "30"
				fromBackup:                ""
				fsType:                    "ext4"
				dataLocality:              "disabled"
				unmapMarkSnapChainRemoved: "ignored"
				disableRevisionCounter:    "true"
				dataEngine:                "v1"
				backupTargetName:          "default"
			}
		}, }
}

// Override longhorn-ui deployment - copy from v1 but change replicas
// CUE doesn't allow overriding concrete values, so we must redefine the whole deployment
_override: deployment: "longhorn-ui": {
	// Copy all fields from v1
	let v1UI = v1.deployment."longhorn-ui"
	apiVersion: v1UI.apiVersion
	kind:       v1UI.kind
	metadata:   v1UI.metadata
	spec: {
		// Copy spec but override replicas
		selector: v1UI.spec.selector
		template: v1UI.spec.template
		replicas: 1 // Our override
	}
}
