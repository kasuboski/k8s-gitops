package josh

configmap: "argocd-rbac-cm": {
	apiVersion: "v1"
	data: {
		"policy.csv": """
			p, role:syncer, applications, get, */*, allow
			p, role:syncer, applications, sync, */*, allow
			p, role:syncer, projects, get, *, allow
			p, role:syncer, repositories, get, *, allow
			"""
		"policy.default": "role:syncer"
	}
	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "argocd-rbac-cm"
			"app.kubernetes.io/part-of": "argocd"
		}
		name:      "argocd-rbac-cm"
		namespace: "argocd"
	}
}
