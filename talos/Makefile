CLUSTER_NAME = pi
CLUSTER_ENDPOINT = 192.168.86.19

RESULT_FOLDER = result

CLUSTER_FILES = controlplane.yaml worker.yaml talosconfig.yaml
CLUSTER_FILES_RESULT = $(addprefix $(RESULT_FOLDER)/,$(CLUSTER_FILES))

.PHONY: bootstrap
bootstrap:
	ifndef NODE
		$(error NODE is not set)
	endif
	talosctl apply-config --insecure -n $(NODE) --file result/$(NODE).yaml
	talosctl --talosconfig=result/talosconfig bootstrap -n $(NODE) -e $(NODE)
	kustomize build ../kube-system | kubectl apply -f -

.PHONY: cluster
cluster: $(CLUSTER_FILES_RESULT)

.PHONY: nodes
nodes: $(RESULT_FOLDER)/controlplane.yaml $(RESULT_FOLDER)/worker.yaml $(RESULT_FOLDER)/tailscale-extensionconfig.yaml
	@../k8s gen nc cherry
	@../k8s gen nc blueberry
	@../k8s gen nc pumpkin
	@../k8s gen nc apple
	@../k8s gen nc adel

$(CLUSTER_FILES_RESULT) &: $(RESULT_FOLDER)/secrets.yaml
	@talosctl gen config --with-secrets $(RESULT_FOLDER)/secrets.yaml $(CLUSTER_NAME) https://$(CLUSTER_ENDPOINT):6443 -o $(RESULT_FOLDER) --force

$(RESULT_FOLDER)/secrets.yaml:
	@bash get-or-create-secrets.sh $(RESULT_FOLDER)/secrets.yaml

$(RESULT_FOLDER)/tailscale-extensionconfig.yaml:
	@doppler secrets substitute tailscale-extensionconfig.yaml -p talos -c boot --output $(RESULT_FOLDER)/tailscale-extensionconfig.yaml

.PHONY: clean
clean:
	rm -f $(RESULT_FOLDER)/*
