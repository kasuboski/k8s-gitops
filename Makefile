.PHONY: cluster-nodes
cluster-nodes: k8s
	@$(MAKE) -C talos nodes

k8s:
	@go build -o k8s