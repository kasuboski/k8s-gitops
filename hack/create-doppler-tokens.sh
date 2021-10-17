#!/usr/bin/env bash

set -ex

APPS="grafana-agent"

for a in $APPS
do
    kubectl create secret generic "$a-token" -n doppler-operator-system --from-literal=serviceToken=$(doppler configs tokens create --project "$a" --config dev "$a-token" --plain)
done