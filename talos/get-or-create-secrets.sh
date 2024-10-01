SECRET_FILE=$1
if [ -z "$SECRET_FILE" ]; then
  echo "Must provide a secret file"
  exit 1
fi

EXISTING=$(doppler secrets get SECRET_YAML -p talos -c boot --plain 2> /dev/null)
if [ -z "$EXISTING" ]; then
  talosctl gen secrets -o "$SECRET_FILE"
  cat "$SECRET_FILE" | doppler secrets set SECRET_YAML -p talos -c boot
else
  if [ ! $(echo "$EXISTING" | cmp -s "$SECRET_FILE") ]; then
    echo "$EXISTING" > "$SECRET_FILE"
  fi
fi

