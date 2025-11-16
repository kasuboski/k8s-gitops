#!/bin/bash
set -e

OUTPUT_FILE=$1
if [ -z "$OUTPUT_FILE" ]; then
  echo "Must provide output file path"
  exit 1
fi

# Get TS_AUTHKEY from Doppler
TS_AUTHKEY=$(doppler secrets get TS_AUTHKEY -p talos -c boot --plain 2>/dev/null || echo "")

if [ -z "$TS_AUTHKEY" ]; then
  echo "Warning: TS_AUTHKEY not found in Doppler, skipping Tailscale extension config"
  exit 0
fi

# Substitute the template
cat tailscale-extensionconfig.yaml | sed "s/{{.TS_AUTHKEY}}/$TS_AUTHKEY/" > "$OUTPUT_FILE"
