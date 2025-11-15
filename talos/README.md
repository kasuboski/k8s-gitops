# Talos Configuration

CUE-based Talos machine configuration management with type safety.

## Usage

```bash
# Generate all node configs
make configs

# Apply config to a node
make apply NODE=cherry

# Validate a config
make validate NODE=cherry
```

## Where to Update

**All configuration is in `../machines.cue`** at the project root:

```cue
// Add/modify common patches
commonPatches: {
  kubeletCert: #Patch & { ... }
}

// Add/modify node definitions
nodes: {
  cherry: #Node & {
    role: "controlplane"
    patches: [...]
  }
}
```

## How It Works

1. **Secrets**: `get-or-create-secrets.sh` fetches/creates `result/secrets.yaml` from Doppler
2. **Base configs**: `talosctl gen config --with-secrets` generates standard `controlplane.yaml` and `worker.yaml`
3. **CUE patches**: `machines.cue` defines minimal patches (only what differs from Talos defaults)
4. **Type checking**: Patches are validated against Talos v1alpha1 schema from `cue.mod/gen/`
5. **Merge**: `talosctl machineconfig patch` applies patches to base configs
6. **Output**: Final configs in `result/<node>.yaml` ready for `talosctl apply-config`

### Type Safety

```bash
# Validate all patches against Talos schema
cue vet ../machines.cue
```

CUE catches typos and type errors before config generation:
- Field name typos (e.g., `validSubnet` → `validSubnets`)
- Type mismatches (e.g., number instead of string)
- Invalid field names
