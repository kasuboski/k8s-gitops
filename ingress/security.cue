package ingress

deployment: "envoy-gateway": spec: template: spec: securityContext: seccompProfile: type: "RuntimeDefault"
