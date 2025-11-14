package envoy_gateway

deployment: "envoy-gateway": spec: template: spec: securityContext: seccompProfile: type: "RuntimeDefault"
