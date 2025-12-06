.PHONY: cluster-configs
cluster-configs: k8s
	@$(MAKE) -C talos configs

.PHONY: k8s
k8s:
	@go build -o k8s

.PHONY: cue-k8s
cue-k8s:
	go get k8s.io/api && cue get go k8s.io/api/...
