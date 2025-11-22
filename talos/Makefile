CLUSTER_NAME = pi
CLUSTER_ENDPOINT = k8s-api.joshcorp.co

RESULT_FOLDER = result

.PHONY: secrets
secrets: $(RESULT_FOLDER)/secrets.yaml

.PHONY: configs
configs: secrets
	@cd .. && ./k8s gen machines

.PHONY: apply
apply:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make apply NODE=cherry" && exit 1)
	@test -f $(RESULT_FOLDER)/$(NODE).yaml || (echo "Config for $(NODE) not found. Run 'make configs' first." && exit 1)
	talosctl apply-config -n $(NODE) -f $(RESULT_FOLDER)/$(NODE).yaml

.PHONY: bootstrap
bootstrap:
	@test -n "$(NODE)" || (echo "NODE is required. Usage: make bootstrap NODE=cherry" && exit 1)
	talosctl bootstrap -n $(NODE)
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
