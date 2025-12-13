package v1

validatingwebhookconfiguration: "vmks-victoria-metrics-operator-admission": {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfiguration"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "vmks"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "victoria-metrics-operator"
			"app.kubernetes.io/version":    "v0.66.1"
			"helm.sh/chart":                "victoria-metrics-operator-0.57.1"
		}
		name: "vmks-victoria-metrics-operator-admission"
	}
	webhooks: [{
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vlagent"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vlagents.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vlagents"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vlcluster"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vlclusters.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vlclusters"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vlogs"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vlogs.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vlogs"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vlsingle"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vlsingles.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vlsingles"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmagent"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmagents.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmagents"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmalertmanagerconfig"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmalertmanagerconfigs.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmalertmanagerconfigs"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmalertmanager"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmalertmanagers.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmalertmanagers"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmalert"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmalerts.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmalerts"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vmanomaly"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmanomalies.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmanomalies"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmauth"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmauths.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmauths"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmcluster"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmclusters.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmclusters"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmnodescrape"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmnodescrapes.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmnodescrapes"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmpodscrape"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmpodscrapes.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmpodscrapes"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmprobe"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmprobes.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmprobes"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmrule"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmrules.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmrules"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmscrapeconfig"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmscrapeconfigs.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmscrapeconfigs"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmservicescrape"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmservicescrapes.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmservicescrapes"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmsingle"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmsingles.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmsingles"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmstaticscrape"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmstaticscrapes.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmstaticscrapes"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1beta1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1beta1-vmuser"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vmusers.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1beta1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vmusers"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vtcluster"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vtclusters.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vtclusters"]
		}]
		sideEffects: "None"
	}, {
		admissionReviewVersions: ["v1"]
		clientConfig: {
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIVENDQWdXZ0F3SUJBZ0lRSW1ZaEpYQ3I0Y0VabUhVWExqL2c2ekFOQmdrcWhraUc5dzBCQVFzRkFEQVoKTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVEFlRncweU5URXlNVE13TlRFNU1ESmFGdzB6TlRFeQpNVEV3TlRFNU1ESmFNQmt4RnpBVkJnTlZCQU1URG5adExXOXdaWEpoZEc5eUxXTmhNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvZjVscDlmQ3FHcWVoUXdiOFczbFRHQkY0QlVEWUdGRVNOYmkKSjF0bVBLKytTR3dTekRHNFFKOXE4NlZCZUVXYld4YTRKQktKc0hidUlwMGV6R09Ya2daMFNMOUFydEg4NmVhUwpyZnRjamxFb2VUcXJuY3E4bHpLVGl4Z3lDTUVUZk5WZTdWbUQrV3pDUCtuV1ZUenc4U3N0Wk0vT0lIZkNCc1h1CjNHZWNOVjNaVXdtRC8xeXdKQW5YcXVFQlRUaVlTSXBJT3J3N3IxdUU0alBJRkIvZFBFL0YvVXQydU9NL284N0cKN092aDRnVzhaaE9MQVdTWWVxMEcwUGFFbkJRdHBMbHFCQTNLNGVSbHZTV2dLU2hPV1c0N3ZzQzZ5RmduREpvNgo1bnhNVTgxdis2ZWsvOU5CQTJzTUxpaCtLb2R2NlZtUG1JMG5PZVdwcFNjMGNpMWNLUUlEQVFBQm8yRXdYekFPCkJnTlZIUThCQWY4RUJBTUNBcVF3SFFZRFZSMGxCQll3RkFZSUt3WUJCUVVIQXdFR0NDc0dBUVVGQndNQ01BOEcKQTFVZEV3RUIvd1FGTUFNQkFmOHdIUVlEVlIwT0JCWUVGRTJNT3lqTGU4MXFXQXNhb1hNZ1ppNGV0VUdmTUEwRwpDU3FHU0liM0RRRUJDd1VBQTRJQkFRQURNazEwNG9Nb3I4Tlp6SUtEcHZBcE5SQVRZMnhOV0Z3WXFJdXBFOHloCjRqRmZESXhXOGdmZERrZzZQZUlvVEtoQjdWNFFOZ0FoRzlsQTZHYmkxbmVxOTA2SUhpMTlPU2d4ZmkyOTRnUXgKcUE3U2lha3UwNEVuNnVwMGliY1FjN3NBcTlDOXBXRE1mVWNMSmcyazVSQ05XY3R1QkEwS1AzZnJYem9ZTUlwYwpUelVVK20xYXI5RWFhT0ZoeHBuaDkyNG1TczlBQWxIcDNOQWtKVHBkQmJLWmhvTE85YkpUbDBWRWI1RVhxSm5QCmFja3ZjTStHc1BYdGpFcXBiN0pmMFNnV2JMTnQ2RVRONkJJRmlnUlhiOVpicHNMcGRZNWlucHlwb3pZdHI1WE0KcS81VEJqZGNlcjlsR1lTajlaTzBKeGx2UlBubFV6LzFSUWtTRzJnTmkxajkKLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
			service: {
				name:      "vmks-victoria-metrics-operator"
				namespace: "victoria-metrics"
				path:      "/validate-operator-victoriametrics-com-v1-vtsingle"
				port:      9443
			}
		}
		failurePolicy: "Fail"
		name:          "vtsingles.operator.victoriametrics.com"
		objectSelector: matchExpressions: [{
			key:      "app.kubernetes.io/name"
			operator: "NotIn"
			values: ["victoria-metrics-operator"]
		}]
		rules: [{
			apiGroups: ["operator.victoriametrics.com"]
			apiVersions: ["v1"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["vtsingles"]
		}]
		sideEffects: "None"
	}]
}
