#!/usr/bin/env bash

set -ex

find . -name '*-secret.yaml' -type f -print0 | while read -d $'\0' file
do
  kubeseal --cert secrets/cert.pem <"$file" > $(sed 's/-secret.yaml/-sealed-secret.json/' <<<$file)
done
