package secrets

deployment: "doppler-operator-controller-manager": spec: template: spec: securityContext: seccompProfile: type: "RuntimeDefault"
deployment: "doppler-operator-controller-manager": spec: template: spec: containers: [{
	name: "manager"
	securityContext: {
		runAsNonRoot: true
		capabilities: {
			drop: _ // somehow set to all?
		}
	}
}]
