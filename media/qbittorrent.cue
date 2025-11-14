package media

deployment: qbittorrent: spec: template: spec: {
	securityContext: fsGroup: 1000
	containers: [{
		name:  "qbittorrent"
		image: "lscr.io/linuxserver/qbittorrent"
		_envMap: {
			PUID:       "1000"
			PGID:       "1000"
			TZ:         "America/Chicago"
			WEBUI_PORT: "8080"
		}
		env: [for k, v in _envMap {name: k, value: v}]
		resources: {
			requests: cpu:  "200m"
			limits: cpu:    "1000m"
			limits: memory: "256Mi"
		}
		ports: [{name: "http", containerPort: 8080}]
		securityContext: {
			runAsNonRoot: false
			// capabilities: drop: ["All"]
		}
		volumeMounts: [{
			name:      "qbittorrent-config"
			mountPath: "/config"
		}, {
			name:      "data"
			subPath:   "downloads"
			mountPath: "/downloads"
		}, {
			name:      "data"
			subPath:   "watch"
			mountPath: "/watch"
		}]
	}, {
		name:  "vpn"
		image: "dperson/openvpn-client"
		livenessProbe: {
			exec: command: ["sh", "-c", "[ \"$(curl -s https://ifconfig.co/city)\" != \"Austin\" ]"]
			initialDelaySeconds: 30
			periodSeconds:       60
		}
		_envMap: {
			FIREWALL: "on"
			ROUTE:    "10.0.0.0/8"
			ROUTE_2:  "100.64.0.0/10"
		}
		env: [for k, v in _envMap {name: k, value: v}]
		volumeMounts: [{
			name:      "vpn-config"
			mountPath: "/vpn"
		}]
		securityContext: capabilities: add: ["NET_ADMIN"]
		securityContext: allowPrivilegeEscalation: false
		resources: {
			requests: cpu:          "100m"
			limits: cpu:            "500m"
			limits: memory:         "64Mi"
			limits: "squat.ai/tun": "1"
		}
	}]
	volumes: [
		{
			name: "qbittorrent-config"
			persistentVolumeClaim: claimName: "qbittorrent"
		},
		{
			name: "data"
			persistentVolumeClaim: claimName: "media-storage"
		},
		{
			name: "vpn-config"
			projected: sources: [
				{
					secret: {
						name: "media-secret"
						_itemsMap: {
							VPN_AUTH:        "vpn.auth"
							VPN_CA:          "ca.crt"
							VPN_CLIENT_CERT: "client.crt"
							VPN_CLIENT_KEY:  "client.key"
						}
						items: [for k, v in _itemsMap {key: k, path: v}]
					}
				},
				{
					configMap: name: "vpn-config"
				},
			]
		},
	]
}

httproute: qbittorrent: {}

persistentvolumeclaim: qbittorrent: {}

service: qbittorrent: {}

configmap: "vpn-config": data: "vpn.conf": """
	client
	remote 87-1-us.cg-dialup.net 443
	dev tun 
	proto udp
	auth-user-pass


	resolv-retry infinite 
	redirect-gateway def1
	persist-key
	persist-tun
	nobind
	cipher AES-256-CBC
	ncp-disable
	auth SHA256
	ping 5
	ping-exit 60
	ping-timer-rem
	explicit-exit-notify 2
	script-security 2
	remote-cert-tls server
	route-delay 5
	verb 4


	ca ca.crt

	cert client.crt

	key client.key
	"""
