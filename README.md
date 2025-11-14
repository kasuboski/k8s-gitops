# Managing Kubernetes with GitOps
[![](https://argocd.joshcorp.co/api/badge?name=apps&revision=true)](https://argocd.joshcorp.co/applications/apps)

This repo is synced with the cluster using [ArgoCD](https://argoproj.github.io/projects/argo-cd).

The cluster is described more [here](https://www.joshkasuboski.com/posts/home-k8s-raspberry-update/).

Secrets are managed by [Doppler](https://www.doppler.com/). This syncs values to a namespace based on a `DopplerSecret` definition.
