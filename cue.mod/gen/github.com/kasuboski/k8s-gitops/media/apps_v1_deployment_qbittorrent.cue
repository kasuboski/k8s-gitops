package media

deployment: qbittorrent: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "qbittorrent"
	spec: {
		selector: matchLabels: "app.kubernetes.io/name": "qbittorrent"
		strategy: type: "Recreate"
		template: {
			metadata: labels: {
				app:                      "qbittorrent"
				"app.kubernetes.io/name": "qbittorrent"
			}
			spec: {
				containers: [{
					env: [{
						name:  "PUID"
						value: "1000"
					}, {
						name:  "PGID"
						value: "1000"
					}, {
						name:  "TZ"
						value: "America/Chicago"
					}, {
						name:  "WEBUI_PORT"
						value: "8080"
					}]
					image: "lscr.io/linuxserver/qbittorrent"
					name:  "qbittorrent"
					ports: [{
						containerPort: 8080
						name:          "web"
					}]
					resources: limits: {
						cpu:    "100m"
						memory: "256Mi"
					}
					volumeMounts: [{
						mountPath: "/config"
						name:      "qbittorrent-config"
					}, {
						mountPath: "/downloads"
						name:      "data"
						subPath:   "downloads"
					}, {
						mountPath: "/watch"
						name:      "data"
						subPath:   "watch"
					}]
				}, {
					env: [{
						name:  "FIREWALL"
						value: "on"
					}, {
						name:  "ROUTE"
						value: "10.0.0.0/8"
					}, {
						name:  "ROUTE_2"
						value: "100.64.0.0/10"
					}]
					image: "dperson/openvpn-client"
					livenessProbe: {
						exec: command: [
							"sh",
							"-c",
							"[ \"$(curl -s https://ifconfig.co/city)\" != \"Austin\" ]",
						]
						initialDelaySeconds: 30
						periodSeconds:       60
					}
					name: "vpn"
					resources: {
						limits: {
							cpu:    "500m"
							memory: "64Mi"
						}
						requests: cpu: "100m"
					}
					securityContext: capabilities: add: ["NET_ADMIN"]
					volumeMounts: [{
						mountPath: "/vpn"
						name:      "vpn-config"
					}]
				}]
				nodeSelector: "topology.kubernetes.io/zone": "austin"
				securityContext: fsGroup: 1000
				volumes: [{
					name: "qbittorrent-config"
					persistentVolumeClaim: claimName: "qbittorrent"
				}, {
					name: "data"
					persistentVolumeClaim: claimName: "media-storage"
				}, {
					name: "vpn-config"
					projected: sources: [{
						secret: {
							items: [{
								key:  "VPN_AUTH"
								path: "vpn.auth"
							}, {
								key:  "VPN_CA"
								path: "ca.crt"
							}, {
								key:  "VPN_CLIENT_CERT"
								path: "client.crt"
							}, {
								key:  "VPN_CLIENT_KEY"
								path: "client.key"
							}]
							name: "media-secret"
						}
					}, {
						configMap: name: "vpn-config-tkh7769cd6"
					}]
				}]
			}
		}
	}
}