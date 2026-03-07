package envoy_gateway

import "encoding/json"

#httpsHosts: [
	{hostname: "*.joshcorp.co", name: "https"},
	{hostname: "*.int.joshcorp.co", name: "https-int"},
	{hostname: "*.ts.joshcorp.co", name: "https-ts"},
]

gateway: http: {
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "Gateway"
	spec: {
		gatewayClassName: "eg"
		infrastructure: parametersRef: {
			group: "gateway.envoyproxy.io"
			kind:  "EnvoyProxy"
			name:  "tailscale"
		}
		listeners: [
			{
				name:     "http"
				protocol: "HTTP"
				port:     80
				allowedRoutes: namespaces: from: "All"
			},
			for _, v in #httpsHosts {
				name:     v.name
				protocol: "HTTPS"
				port:     443
				hostname: v.hostname
				tls: {
					mode: "Terminate"
					certificateRefs: [
						{
							name:  "joshcorp-tls"
							kind:  "Secret"
							group: ""
						},
					]
				}
				allowedRoutes: namespaces: from: "All"
			},
		]
	}
}

certificate: "joshcorp-wildcard": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	spec: {
		secretName: "joshcorp-tls"
		issuerRef: {
			name: "letsencrypt-prod"
			kind: "ClusterIssuer"
		}
		commonName: "*.joshcorp.co"
		dnsNames: [
			"*.joshcorp.co",
			"*.int.joshcorp.co",
			"*.ts.joshcorp.co",
		]
	}
}

#AccessLogFormat: {
	":authority":                      "%REQ(:AUTHORITY)%"
	bytes_received:                    "%BYTES_RECEIVED%"
	bytes_sent:                        "%BYTES_SENT%"
	client_ip:                         "%DOWNSTREAM_REMOTE_ADDRESS_WITHOUT_PORT%"
	connection_termination_details:    "%CONNECTION_TERMINATION_DETAILS%"
	downstream_local_address:          "%DOWNSTREAM_LOCAL_ADDRESS%"
	downstream_remote_address:         "%DOWNSTREAM_REMOTE_ADDRESS%"
	duration:                          "%DURATION%"
	method:                            "%REQ(:METHOD)%"
	protocol:                          "%PROTOCOL%"
	requested_server_name:             "%REQUESTED_SERVER_NAME%"
	response_code:                     "%RESPONSE_CODE%"
	response_code_details:             "%RESPONSE_CODE_DETAILS%"
	response_flags:                    "%RESPONSE_FLAGS%"
	route_name:                        "%ROUTE_NAME%"
	start_time:                        "%START_TIME%"
	upstream_cluster:                  "%UPSTREAM_CLUSTER%"
	upstream_host:                     "%UPSTREAM_HOST%"
	upstream_local_address:            "%UPSTREAM_LOCAL_ADDRESS%"
	upstream_transport_failure_reason: "%UPSTREAM_TRANSPORT_FAILURE_REASON%"
	"user-agent":                      "%REQ(USER-AGENT)%"
	"x-envoy-origin-path":             "%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%"
	"x-envoy-upstream-service-time":   "%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%"
	"x-forwarded-for":                 "%REQ(X-FORWARDED-FOR)%"
	"x-request-id":                    "%REQ(X-REQUEST-ID)%"
}

envoyproxy: tailscale: {
	apiVersion: "gateway.envoyproxy.io/v1alpha1"
	kind:       "EnvoyProxy"
	spec: {
		provider: {
			type: "Kubernetes"
			kubernetes: envoyService: {
				annotations: {
					"tailscale.com/expose":   "true"
					"tailscale.com/hostname": "homelab-gateway"
				}
				loadBalancerClass: "tailscale"
				name:              "homelab-gateway"
			}
		}
		telemetry: accessLog: settings: [
			{
				format: {
					type: "Text"
					text: "\(json.Marshal(#AccessLogFormat))\n"
				}
				sinks: [
					{
						type: "File"
						file: path: "/dev/stdout"
					},
				]
			},
		]
	}
}
