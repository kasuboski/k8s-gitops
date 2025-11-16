.PHONY: cluster-configs
cluster-configs: k8s
	@$(MAKE) -C talos configs

.PHONY: k8s
k8s:
	@go build -o k8s

ingress/envoy-gateway.download.cue: ingress/envoy-gateway.download.yaml 
	cue import yaml -p ingress -f -l 'strings.ToLower(kind)' -l 'metadata.name' -R -i ingress/envoy-gateway.download.yaml

ingress/envoy-gateway.download.yaml:
	./k8s download https://github.com/envoyproxy/gateway/releases/download/v1.1.2/install.yaml ingress/envoy-gateway.download.yaml

secrets/doppler-operator.yaml:
	./k8s download https://github.com/DopplerHQ/kubernetes-operator/releases/download/v1.5.1/recommended.yaml secrets/doppler-operator.yaml

secrets/doppler-operator.cue: secrets/doppler-operator.yaml
	cue import yaml -p secrets -f -l 'strings.ToLower(kind)' -l 'metadata.name' -R -i secrets/doppler-operator.yaml

.PHONY: cue-k8s
cue-k8s:
	go get k8s.io/api && cue get go k8s.io/api/...
