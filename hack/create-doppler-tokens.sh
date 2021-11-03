#!/usr/bin/env bash

set -ex

APPS="grafana-agent media default"

for a in $APPS
do
    kubectl delete secret "$a-token" -n doppler-operator-system --ignore-not-found
    kubectl create secret generic "$a-token" -n doppler-operator-system --from-literal=serviceToken=$(doppler configs tokens create --project "$a" --config dev "$a-token" --plain)
done