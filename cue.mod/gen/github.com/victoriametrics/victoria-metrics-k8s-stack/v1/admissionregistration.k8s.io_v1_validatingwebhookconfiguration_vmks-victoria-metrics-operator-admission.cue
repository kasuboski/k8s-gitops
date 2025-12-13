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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
			caBundle: "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURIakNDQWdhZ0F3SUJBZ0lSQU1QN2srcHg2ZVRGKzB3SGR4aVptU3d3RFFZSktvWklodmNOQVFFTEJRQXcKR1RFWE1CVUdBMVVFQXhNT2RtMHRiM0JsY21GMGIzSXRZMkV3SGhjTk1qVXhNakV6TVRjME5EVTFXaGNOTXpVeApNakV4TVRjME5EVTFXakFaTVJjd0ZRWURWUVFERXc1MmJTMXZjR1Z5WVhSdmNpMWpZVENDQVNJd0RRWUpLb1pJCmh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSjNlN3ZlZElSbnlTZC9zY0JpeFVCZGZQbmlpWmVGSHN5R1MKVWNTRnpHZVFDMldtOG8rMnBOQzBzWkJBN2RwL3IxRnZvWGJVQjZwNnBOM056dDcydm9ET002U253dURmaXdmQQpWLzh6RC9hQ3ZKc1EwditJVVBZa2p6dEZLakdrL1NsbXdmdG9TM2EvSVQ1MWtvZXl6SE1tanN1WXRCZFNVcUN6CkxKci9aTG9idHNwT3Y1S0VVeHYwWmhSUENxNHlWNlp6WVF4WFFheVRyNEZDdFhJYzNBd2NPZ2RDTWtTZDRHUjYKWnhZZGYwSUhUa2VMN25VSzFXY0ZxcDN1ZG1QYnc2VVZLZW8zbDVQZkVwUmR2UkNLOVluaHFNWkVJc3RlcllvUApORkx4WlROU2VXSjdDWVNwT1hHb3FCNko5SE1kdko2cWpoczN4RitJVG9lVmtLKzFsK3NDQXdFQUFhTmhNRjh3CkRnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXTUJRR0NDc0dBUVVGQndNQkJnZ3JCZ0VGQlFjREFqQVAKQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVdCQlFZM0dMSnF1TDZuazJRYUNqOTh5N0ozaGpidURBTgpCZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFnZFNQVEk1dThjSE8rQis5MzZjY0Q5SjlBNWszWkhydjRHb29DZVExCitFOE1YOUpqZEFuQUpEYzFRdm81YXZ3YSsxZm8zMHJUdllVdWtTKzU1Y3dpYW9maWlGN2xvM0srSGRoOXpwdlkKeG5GMjJjVUp6UElWRGVNZ3l5ZjNTUGR1UklVUzNydlN0MFFFL1hsTDk4YkQyOThkenQyYzFqR1hocVhJUk9aNgptbmlPYTg1QlpuTjBUVmd1VHorQTdoUERnNUp5M2ZEYllUd21NS1V4UHVYL1NwWlVKRytwZG14OGdKeXh4N0kyCk40Yyt5OEEvbFNoN0orVVptcjJtWEJzYWV3ZitPNzN1WElCWVNXWGtla1ZITVE5eWx3czdISnBhTGMybC9DZnIKUmlDVFhXeStYNmROR09vMzJxMHhTeFJ4UFI1bnI2ZFpLRDkyOTVUbUxrNGpqUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
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
