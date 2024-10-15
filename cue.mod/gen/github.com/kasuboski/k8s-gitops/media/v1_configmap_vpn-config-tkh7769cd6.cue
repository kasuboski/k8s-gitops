package media

configmap: "vpn-config-tkh7769cd6": {
	apiVersion: "v1"
	data: "vpn.conf": """
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
	kind: "ConfigMap"
	metadata: name: "vpn-config-tkh7769cd6"
}
