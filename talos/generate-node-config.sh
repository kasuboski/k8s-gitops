set -e

NODE_NAME=$1
if [ -z "$NODE_NAME" ]; then
  echo "Must provide the node name"
  exit 1
fi

RESULT_FOLDER=result

NODE_ROLE=$(yq -r ".nodes."$NODE_NAME".role" < cluster.yaml)
BASE_CONFIG=""

NODE_PATCHES=(kubelet-cert-patch.yaml kubelet-ip-patch.yaml vip-patch.yaml "$RESULT_FOLDER/tailscale-extensionconfig.yaml")

if [ "$NODE_ROLE" == "controlplane" ]; then
  BASE_CONFIG="$RESULT_FOLDER/controlplane.yaml"
else
  BASE_CONFIG="$RESULT_FOLDER/worker.yaml"
fi

if [ -f "$NODE_NAME-patch.yaml" ]; then
  NODE_PATCHES+=("$NODE_NAME-patch.yaml")
fi

NODE_PATCHES+=($(yq -r ".nodes."$NODE_NAME".patches | @sh" < cluster.yaml | sed "s/'//g"))

PATCH_ARGS=()
for PATCH in "${NODE_PATCHES[@]}"; do
  PATCH_ARGS+=("--patch" "@$PATCH")
done

talosctl machineconfig patch "$BASE_CONFIG" \
		"${PATCH_ARGS[@]}" \
		--output "$RESULT_FOLDER/$NODE_NAME.yaml"
