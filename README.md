# Managing Kubernetes with GitOps
[![](https://argocd.joshcorp.co/api/badge?name=apps&revision=true)](https://argocd.joshcorp.co/applications/apps)

This repo is synced with the cluster using [ArgoCD](https://argoproj.github.io/projects/argo-cd). Not everything is automatic, mainly things with a secret and helm charts.

That cluster is described more [here](https://www.joshkasuboski.com/posts/home-k8s-raspberry-update/).

Managing secrets in git isn't fully figured out yet. It currently uses git-crypt to encrypt the one secret. You can find a walkthrough [here](https://buddy.works/guides/git-crypt).