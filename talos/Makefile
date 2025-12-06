# Cluster configuration is now defined in machines/cluster.cue
# This is the single source of truth for cluster name, endpoints, and node IPs

RESULT_FOLDER = result

# Optional flags
INSECURE_FLAG = $(if $(INSECURE),--insecure,)

.PHONY: help
help:
	@echo "Talos Configuration Management"
	@echo ""
	@echo "Common workflows:"
	@echo "  make configs              - Generate machine configs from CUE definitions"
	@echo "  make apply NODE=adel INSECURE=1  - Initial apply with --insecure flag"
	@echo "  make apply NODE=adel      - Apply config updates (after initial setup)"
	@echo "  make bootstrap NODE=adel  - Bootstrap the cluster"
	@echo "  make validate NODE=adel   - Validate a machine config"
	@echo "  make node-ip NODE=adel    - Show node IP from cluster config"
	@echo ""
	@echo "First-time setup example:"
	@echo "  1. make configs"
	@echo "  2. make apply NODE=adel INSECURE=1"
	@echo "  3. make bootstrap NODE=adel"
	@echo ""

.PHONY: secrets
secrets: $(RESULT_FOLDER)/secrets.yaml

.PHONY: configs
configs: secrets
	@cd .. && ./k8s gen machines

.PHONY: apply
apply:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make apply NODE=adel [INSECURE=1]" && exit 1)
	@test -f $(RESULT_FOLDER)/$(NODE).yaml || (echo "Config for $(NODE) not found. Run 'make configs' first." && exit 1)
	@NODE_IP=$$(cue export ../machines/cluster.cue -e "cluster.nodeEndpoints.$(NODE)" 2>/dev/null | tr -d '"'); \
	test -n "$$NODE_IP" || (echo "Node $(NODE) not found in cluster config" && exit 1); \
	if [ -n "$(INSECURE)" ]; then \
		echo "Applying config to $(NODE) ($$NODE_IP) with --insecure (initial setup)"; \
	else \
		echo "Applying config to $(NODE) ($$NODE_IP)"; \
	fi; \
	talosctl apply-config -n $$NODE_IP -f $(RESULT_FOLDER)/$(NODE).yaml $(INSECURE_FLAG)

.PHONY: node-ip
node-ip:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make node-ip NODE=adel" && exit 1)
	@cue export ../machines/cluster.cue -e "cluster.nodeEndpoints.$(NODE)" 2>/dev/null || echo "Node $(NODE) not found in cluster config"

.PHONY: bootstrap
bootstrap:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make bootstrap NODE=adel" && exit 1)
	@NODE_IP=$$(cue export ../machines/cluster.cue -e "cluster.nodeEndpoints.$(NODE)" 2>/dev/null | tr -d '"'); \
	test -n "$$NODE_IP" || (echo "Node $(NODE) not found in cluster config" && exit 1); \
	echo "Bootstrapping cluster on $(NODE) ($$NODE_IP)"; \
	talosctl bootstrap -n $$NODE_IP; \
	talosctl kubeconfig --nodes; \
	kustomize build ../kube-system | kubectl apply -f -

.PHONY: validate
validate:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make validate NODE=cherry" && exit 1)
	@test -f $(RESULT_FOLDER)/$(NODE).yaml || (echo "Config for $(NODE) not found. Run 'make configs' first." && exit 1)
	talosctl validate --strict -c $(RESULT_FOLDER)/$(NODE).yaml -m metal

$(RESULT_FOLDER)/secrets.yaml:
	@bash get-or-create-secrets.sh $(RESULT_FOLDER)/secrets.yaml

.PHONY: clean
clean:
	rm -rf $(RESULT_FOLDER)/
