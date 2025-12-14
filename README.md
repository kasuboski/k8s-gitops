# Managing Kubernetes with GitOps
[![](https://argocd.joshcorp.co/api/badge?name=apps&revision=true)](https://argocd.joshcorp.co/applications/apps)

This is a GitOps-based Kubernetes infrastructure repository for a home cluster running on Talos Linux. It uses **CUE** (Configure, Unify, Execute) for type-safe configuration and manifest generation, with **ArgoCD** providing continuous delivery.

The cluster is described more [here](https://www.joshkasuboski.com/posts/home-k8s-raspberry-update/).

## Overview

### Repository Structure

- **Root CUE files** (`*.cue`) - Application definitions and schema mappings
- **`kube.cue`** - Defines the Schema all Kubernetes resources must adhere to. Includes list of known Kinds
- **`manifests/`** - Generated Kubernetes manifests (JSON) consumed by ArgoCD
- **`cue.mod/gen/`** - Vendored upstream manifests converted to CUE schemas
- **Component directories** (`networking/`, `storage/`, `media/`, etc.) - Application-specific configurations
- **`machines/`** - Talos Linux machine configurations
- **`pkg/`** & **`cmd/`** - Custom Go tooling for manifest generation
- **`talos/`** - Talos OS configuration tooling

### How It Works

1. **Define**: Applications are defined in CUE files with type safety via Kubernetes API schemas
2. **Vendor**: External resources are fetched and converted to CUE using `./k8s vendor`
3. **Generate**: Kubernetes manifests are generated from CUE using `./k8s generate manifests`
4. **Deploy**: ArgoCD monitors the `manifests/` directory and syncs changes to the cluster automatically

### Key Technologies

- **CUE (v0.15.0)** - Type-safe configuration language with schema validation
- **ArgoCD** - GitOps continuous delivery using the "App of Apps" pattern
- **Talos Linux** - Immutable Kubernetes operating system
- **MetalLB** - Bare metal load balancer
- **Doppler** - Secrets management (syncs values to namespaces via `DopplerSecret` CRDs)
- **Envoy Gateway** - Ingress and API gateway
