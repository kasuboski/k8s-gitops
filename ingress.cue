package apps

apps: ingress: {
  namespace: "envoy-gateway-system"
  resources: [{
    apiVersion: "gateway.networking.k8s.io/v1"
    kind: "GatewayClass"
    metadata: name: "eg"
    spec: controllerName: "gateway.envoyproxy.io/gatewayclass-controller" 
  },
  {
    apiVersion: "gateway.networking.k8s.io/v1"
    kind: "Gateway"
    metadata: name: "http"
    spec: gatewayClassName:  "eg"
    spec: listeners: [{
      name: "http"
      protocol: "HTTP"
      port: 80
      allowedRoutes: namespaces: from: "ALL"
    }]
  }]
} 