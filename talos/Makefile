CLUSTER_NAME = pi
CLUSTER_ENDPOINT = '192.168.86.19'

RESULT_FOLDER = result

CLUSTER_FILES = controlplane.yaml worker.yaml talosconfig.yaml
CLUSTER_FILES_RESULT = $(addprefix $(RESULT_FOLDER)/,$(CLUSTER_FILES))

.PHONY: bootstrap
bootstrap:
	ifndef NODE
		$(error NODE is not set)
	endif
	talosctl apply-config --insecure -n $(NODE) --file result/cherry.yaml
	talosctl --talosconfig=result/talosconfig bootstrap -n $(NODE) -e $(NODE)
	kubectl apply -f https://raw.githubusercontent.com/alex1989hu/kubelet-serving-cert-approver/main/deploy/standalone-install.yaml
	talosctl --talosconfig=result/talosconfig config endpoint $(CLUSTER_ENDPOINT)

.PHONY: cluster
cluster: $(CLUSTER_FILES_RESULT)

$(RESULT_FOLDER)/cherry.yaml: $(RESULT_FOLDER)/controlplane.yaml $(RESULT_FOLDER)/tailscale-extensionconfig.yaml
	talosctl machineconfig patch $(RESULT_FOLDER)/controlplane.yaml \
		--patch @cherry-patch.yaml \
		--patch @kubelet-cert-patch.yaml \
		--patch @vip-patch.yaml \
		--patch @ephemeral-usb-patch.yaml \
		--patch @sdcard-install-patch.yaml \
		--patch @$(RESULT_FOLDER)/tailscale-extensionconfig.yaml \
		--patch @austin-labels-patch.yaml \
		--output $(RESULT_FOLDER)/cherry.yaml

$(CLUSTER_FILES_RESULT) &: $(RESULT_FOLDER)/secrets.yaml
	talosctl gen config --with-secrets $(RESULT_FOLDER)/secrets.yaml $(CLUSTER_NAME) https://$(CLUSTER_ENDPOINT):6443 -o $(RESULT_FOLDER) --force

$(RESULT_FOLDER)/secrets.yaml:
	@bash get-or-create-secrets.sh $(RESULT_FOLDER)/secrets.yaml

$(RESULT_FOLDER)/tailscale-extensionconfig.yaml:
	@doppler secrets substitute tailscale-extensionconfig.yaml -p talos -c boot --output $(RESULT_FOLDER)/tailscale-extensionconfig.yaml

.PHONY: clean
clean:
	rm -f $(RESULT_FOLDER)/*
