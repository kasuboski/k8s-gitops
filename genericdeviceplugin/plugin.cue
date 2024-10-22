package genericdeviceplugin

import "encoding/json"

_nameLabel: "app.kubernetes.io/name": "generic-device-plugin"
daemonset: "generic-device-plugin": {
  metadata: labels: _nameLabel
  spec: {
    selector: matchLabels: _nameLabel
    template: {
      metadata: labels: _nameLabel
      spec: {
        priorityClassName: "system-node-critical"
        tolerations: [
          {
            operator: "Exists"
            effect: "NoExecute"
          },
          {
            operator: "Exists"
            effect: "NoSchedule"
          }
        ]
        containers: [{
          name: "generic-device-plugin"
          image: "ghcr.io/squat/generic-device-plugin"
          args: [
            "--device",
            json.Marshal({
              name: "tun"
              groups: [{
                count: 1000
                paths: [{path: "/dev/net/tun"}]
              }]
            })
          ]
          resources: {
            requests: cpu: "50m"
            requests: memory: "10Mi"
            limits: cpu: "50"
            limits: memory: "20Mi"
          }
          ports: [{containerPort: 8080, name: "http"}]
          securityContext: privileged: true
          volumeMounts: [
            {
              name: "device-plugin"
              mountPath: "/var/lib/kubelet/device-plugins"
            },
            {
              name: "dev"
              mountPath: "/dev"
            },
          ]
        }]
        volumes: [
          {
            name: "device-plugin"
            hostPath: path: "/var/lib/kubelet/device-plugins"
          },
          {
            name: "dev"
            hostPath: path: "/dev"
          },
        ]
      }
    }
  }
}

