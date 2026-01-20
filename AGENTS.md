MUST Read @README.md for a project overview.

Editing `vendor.cue` REQUIRES you to run `./k8s vendor`. This will update the `cue.mod/` directory with the vendored contents.
After revendoring you can run `./k8s generate manifests` to update the `manifests/` directory. The error "field not found: appsApp" happens when there's any syntax/validation error in the CUE files

Using `cue vet` on individual files is helpful to narrow down errors.

The cloudflare-gateway/cloudflare Gateway ends up exposed to the internet. The envoy-gateway-system/http Gateway is only exposed to my local network.
