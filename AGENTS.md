MUST Read @README.md for a project overview.

Editing `vendor.cue` REQUIRES you to run `./k8s vendor`. This will update the `cue.mod/` directory with the vendored contents.
After revendoring you can run `./k8s generate manifests` to update the `manifests/` directory.

### Common Errors
"field not found: appsApp" happens when there's any syntax/validation error in the CUE files
"couldn't marshal to json: json: error calling MarshalJSON for type cue.Value: cue: marshal error: <path>.<kind>: field not allowed" happens when a new kind is used. It needs to be added to `#Kinds` in `kube.cue`. Run `cue eval -e '#KindGen'` to generate the updated `#Kinds`

Using `cue vet` on individual files is helpful to narrow down errors.

The cloudflare-gateway/cloudflare Gateway ends up exposed to the internet. The envoy-gateway-system/http Gateway is only exposed to my local network.
