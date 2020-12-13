# Managing Kubernetes with GitOps
[![](https://argocd.joshcorp.co/api/badge?name=apps&revision=true)](https://argocd.joshcorp.co/applications/apps)

This repo is synced with the cluster using [ArgoCD](https://argoproj.github.io/projects/argo-cd). Not everything is automatic, mainly things with a helm chart.

The cluster is described more [here](https://www.joshkasuboski.com/posts/home-k8s-raspberry-update/).

Managing secrets in git is done using [SealedSecrets](https://github.com/bitnami-labs/sealed-secrets). It currently uses git-crypt to encrypt secrets. You can find a walkthrough [here](https://buddy.works/guides/git-crypt). Those secrets are then used to create sealed secrets using `hack/encrypt-secrets.sh`.
