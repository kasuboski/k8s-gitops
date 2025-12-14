MUST Read @README.md for a project overview.

Editing `vendor.cue` REQUIRES you to run `./k8s vendor`. This will update the `cue.mod/` directory with the vendored contents.
After revendoring you can run `./k8s generate manifests` to update the `manifests/` directory.

Using `cue vet` on individual files is helpful to narrow down errors.
