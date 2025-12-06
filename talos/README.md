# Talos Kubernetes Cluster

> CUE-based Talos machine configuration management with type safety and GitOps

This repository manages a Talos Linux Kubernetes cluster using declarative CUE configurations, providing type safety, validation, and minimal patch-based configuration management.

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Initial Cluster Setup](#initial-cluster-setup)
- [Configuration & Deployment](#configuration--deployment)
- [Verification & Access](#verification--access)
- [Operations](#operations)
- [How It Works](#how-it-works)
- [Troubleshooting](#troubleshooting)

## Architecture Overview

**Current Cluster Configuration:**

- **Control Plane:** 1 node (adel) - x86 Intel machine
- **Workers:** 4 nodes (cherry, blueberry, pumpkin, apple) - Raspberry Pi devices
- **Networking:** KubeSpan mesh networking with Sidero Labs discovery service
- **API Access:** DNS-based via `k8s-api.joshcorp.co`

**Network Configuration:**
- Cluster Domain: `cluster.local`
- Pod CIDR: `10.244.0.0/16`
- Service CIDR: `10.96.0.0/12`
- Region: `home`, Zone: `austin`

## Prerequisites

### Required Tools

1. **talosctl** - Talos CLI tool

   ```bash
   # macOS
   brew install siderolabs/tap/talosctl

   # Linux
   curl -sL https://talos.dev/install | sh
   ```

2. **kubectl** - Kubernetes CLI

   ```bash
   # macOS
   brew install kubectl

   # Linux
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   chmod +x kubectl && sudo mv kubectl /usr/local/bin/
   ```

3. **Doppler CLI** - Secrets management

   ```bash
   # macOS
   brew install dopplerhq/cli/doppler

   # Linux
   curl -Ls https://cli.doppler.com/install.sh | sh
   ```

4. **CUE** - Configuration language (optional, for validation)

   ```bash
   # macOS
   brew install cue-lang/tap/cue

   # Linux
   go install cuelang.org/go/cmd/cue@latest
   ```

5. **Make** - Build automation (usually pre-installed)

### Hardware Requirements

**Control Plane (adel):**
- x86 Intel architecture
- Minimum: 2 CPU cores, 4GB RAM, 20GB disk
- Network: Static or DHCP with reserved IP

**Workers (Raspberry Pi):**
- Raspberry Pi 4 or 5 (4GB+ RAM recommended)
- MicroSD card (32GB+ Class 10 or better)
- Optional: USB drive for ephemeral storage
- Network: DHCP with reserved IPs

### Network Requirements

1. **DNS Configuration:**
   - Create A record: `k8s-api.joshcorp.co` → Control plane IP
   - Ensure all nodes can resolve this DNS name

2. **DHCP:**
   - Reserved IP addresses for all cluster nodes
   - Stable IPs prevent cluster disruption on reboots

3. **Firewall/Ports:**
   - `6443/tcp` - Kubernetes API server
   - `50000/tcp` - Talos API (apid)
   - KubeSpan (WireGuard) - Managed automatically by Talos
   - Allow inter-node communication on all required Kubernetes ports

4. **Internet Access:**
   - Required for pulling container images
   - Talos OS updates and time synchronization
   - Sidero Labs discovery service (KubeSpan)

### Doppler Setup

1. Authenticate with Doppler:
   ```bash
   doppler login
   ```

2. Ensure you have access to the `talos` project with `boot` environment/config.

## Initial Cluster Setup

### Step 1: Download Talos Image

**For Control Plane (x86):**

Use the Image Factory schematic ID: `249d9135de54962744e917cfe654117000cba369f9152fbab9d055a00aa3664f`

```bash
# Download ISO
curl -Lo talos-amd64.iso \
  https://factory.talos.dev/image/249d9135de54962744e917cfe654117000cba369f9152fbab9d055a00aa3664f/v1.8.1/metal-amd64.iso

# Or download disk image for direct write
curl -Lo talos-amd64.raw.xz \
  https://factory.talos.dev/image/249d9135de54962744e917cfe654117000cba369f9152fbab9d055a00aa3664f/v1.8.1/metal-amd64.raw.xz
```

**For Workers (Raspberry Pi):**

```bash
# Download Raspberry Pi image
curl -Lo talos-arm64.img.xz \
  https://factory.talos.dev/image/<your-rpi-schematic-id>/v1.8.1/metal-arm64.img.xz
```

> **Note:** Create your own schematic at [factory.talos.dev](https://factory.talos.dev) if you need specific system extensions (e.g., network drivers, storage drivers).

### Step 2: Flash Installation Media

**For x86 Control Plane:**

```bash
# Create bootable USB (macOS)
sudo dd if=talos-amd64.iso of=/dev/diskX bs=1m

# Or write disk image directly to target disk
xz -d talos-amd64.raw.xz
sudo dd if=talos-amd64.raw of=/dev/sdX bs=4M status=progress
```

**For Raspberry Pi Workers:**

```bash
# Flash SD card (macOS)
xz -d talos-arm64.img.xz
sudo dd if=talos-arm64.img of=/dev/diskX bs=1m status=progress

# Or use balenaEtcher GUI tool
```

### Step 3: Boot All Nodes

1. **Boot control plane node (adel)** from USB/ISO or directly from disk
2. **Boot worker nodes** from SD cards
3. Wait for Talos dashboard to appear on each console
4. Note the IP address displayed on each node's console

> **Tip:** If no display is available, check your DHCP server's lease table for the assigned IP addresses.

### Step 4: Note Node IPs

Record the IP addresses assigned to your nodes - you'll need these for applying configurations:

```bash
# Example - save these for later use
export ADEL_IP=192.168.X.X
export CHERRY_IP=192.168.X.X
export BLUEBERRY_IP=192.168.X.X
export PUMPKIN_IP=192.168.X.X
export APPLE_IP=192.168.X.X
```

> **Note:** Node IPs are assigned via DHCP. The cluster uses `kubeletIP` with `validSubnets: ["0.0.0.0/0"]` to allow kubelet to bind to any IP. Nodes are identified by hostname, not static IPs.

### Step 5: Verify Disk Availability

Check available disks on your control plane to confirm the installation target:

```bash
# Set control plane IP
export CONTROL_PLANE_IP=<adel-ip-address>

# List disks (use --insecure before applying config)
talosctl get disks --insecure --nodes $CONTROL_PLANE_IP
```

Note the disk ID (e.g., `sda`, `sdb`, `nvme0n1`) - this should match what's configured in `machines.cue`.

## Configuration & Deployment

### Quick Start

```bash
# 1. Generate/fetch secrets from Doppler
make secrets

# 2. Generate all node configurations
make configs

# 3. Validate a configuration (optional)
make validate NODE=cherry

# 4. Apply configuration to a node
make apply NODE=adel
make apply NODE=cherry
# ... repeat for all nodes

# 5. Bootstrap the cluster (run ONCE on control plane)
make bootstrap NODE=adel
```

### Step-by-Step Workflow

#### 1. Secrets Management

```bash
make secrets
```

This command:
- Fetches `SECRET_YAML` from Doppler (project: `talos`, config: `boot`)
- Or generates new secrets with `talosctl gen secrets` if not present
- Stores secrets in `talos/result/secrets.yaml`

#### 2. Generate Configurations

```bash
make configs
```

This command:
- Loads node definitions from `machines/machines.cue`
- Runs `talosctl gen config --with-secrets` to create base configs
- Applies CUE-defined patches for each node
- Outputs final configs to `talos/result/<node>.yaml`

#### 3. Apply Configurations to Nodes

Apply to control plane first:

```bash
make apply NODE=adel
```

Then apply to workers:

```bash
make apply NODE=cherry
make apply NODE=blueberry
make apply NODE=pumpkin
make apply NODE=apple
```

> **Note:** Nodes must be running Talos from the ISO/disk image before applying configs.

#### 4. Bootstrap the Cluster

**Run this ONCE on a SINGLE control plane node:**

```bash
make bootstrap NODE=adel
```

This command:
- Runs `talosctl bootstrap` to initialize etcd
- Applies kube-system manifests (metrics-server, cert-approver)
- Sets up core Kubernetes components

> **Warning:** Only run bootstrap once. Running it multiple times can corrupt your etcd cluster.

## Verification & Access

### 1. Set Talos Endpoints

Configure `talosctl` to communicate with your cluster:

```bash
export CONTROL_PLANE_IP=<adel-ip>
talosctl --talosconfig=./result/talosconfig config endpoints $CONTROL_PLANE_IP
```

### 2. Check Cluster Health

```bash
talosctl --talosconfig=./result/talosconfig health --nodes $CONTROL_PLANE_IP
```

Expected output:
```
waiting for etcd to be healthy: OK
waiting for apid to be ready: OK
waiting for kubelet to be healthy: OK
...
```

### 3. Get Kubernetes Access

Retrieve your `kubeconfig`:

```bash
# Merge with default kubeconfig
talosctl kubeconfig --nodes $CONTROL_PLANE_IP --talosconfig=./result/talosconfig

# Or save to separate file
talosctl kubeconfig alternative-kubeconfig --nodes $CONTROL_PLANE_IP --talosconfig=./result/talosconfig
export KUBECONFIG=./alternative-kubeconfig
```

### 4. Verify Node Registration

```bash
kubectl get nodes
```

Expected output:
```
NAME        STATUS   ROLES           AGE   VERSION
adel        Ready    control-plane   5m    v1.31.1
cherry      Ready    <none>          4m    v1.31.1
blueberry   Ready    <none>          4m    v1.31.1
pumpkin     Ready    <none>          4m    v1.31.1
apple       Ready    <none>          4m    v1.31.1
```

### 5. Verify KubeSpan Mesh

Check KubeSpan status on each node:

```bash
talosctl get kubespanidentities --nodes $CONTROL_PLANE_IP
talosctl get kubespanpeerstatus --nodes $CONTROL_PLANE_IP
```

All nodes should show as connected peers in the WireGuard mesh.

### 6. Check System Pods

```bash
kubectl get pods -n kube-system
```

Ensure all system pods are running:
- `coredns-*`
- `kube-apiserver-*`
- `kube-controller-manager-*`
- `kube-scheduler-*`
- `kube-proxy-*`
- `metrics-server-*`
- `kubelet-serving-cert-approver-*`

## Operations

### Updating Node Configuration

After modifying `machines/machines.cue`:

```bash
# Regenerate configs
make configs

# Apply updated config to specific node
make apply NODE=cherry

# Node will reboot automatically to apply changes
```

### Adding a New Worker Node

1. **Update `machines/machines.cue`:**

   ```cue
   // Add node-specific patch
   nodePatches: {
     // ... existing patches ...

     newnode: #Patch & {
       machine: {
         install: disk: "/dev/mmcblk0"  // or appropriate disk
         network: hostname: "newnode"
       }
     }
   }

   // Add node definition
   nodes: {
     // ... existing nodes ...

     newnode: #Node & {
       role: "worker"
       patches: [
         commonPatches.kubeletCert,
         commonPatches.kubeletIP,
         commonPatches.austinLabels,
         kubespanEnabled,
         hardwarePatches.sdcardInstall,  // or omit if x86
         // hardwarePatches.ephemeralUSB,  // optional for USB storage
         nodePatches.newnode,
       ]
     }
   }
   ```

2. **Boot the new node** with Talos ISO/image

3. **Generate and apply config:**

   ```bash
   make configs
   make apply NODE=newnode
   ```

4. **Verify node joins:**

   ```bash
   kubectl get nodes
   ```

### Upgrading Talos OS

```bash
# Check current version
talosctl version --nodes $CONTROL_PLANE_IP

# Upgrade control plane
talosctl upgrade --nodes $CONTROL_PLANE_IP \
  --image factory.talos.dev/installer/249d9135de54962744e917cfe654117000cba369f9152fbab9d055a00aa3664f:v1.9.0

# Upgrade workers one at a time
talosctl upgrade --nodes cherry \
  --image factory.talos.dev/installer/<schematic-id>:v1.9.0

# Wait for each to complete before upgrading the next
```

### Upgrading Kubernetes

1. **Update `machines/machines.cue`:**

   ```cue
   kubernetesVersion: "1.32.0"  // Update version
   ```

2. **Regenerate and apply configs:**

   ```bash
   make configs
   make apply NODE=adel
   # Wait for control plane to upgrade
   make apply NODE=cherry
   # ... etc
   ```

### Backing Up etcd

```bash
talosctl -n $CONTROL_PLANE_IP etcd snapshot etcd-backup.db
```

### Disaster Recovery

If you need to rebuild the cluster:

1. Ensure `talos/result/secrets.yaml` is backed up in Doppler
2. Boot all nodes with Talos ISO
3. Run through Configuration & Deployment steps
4. Restore etcd snapshot if needed:
   ```bash
   talosctl -n $CONTROL_PLANE_IP bootstrap --recover-from=etcd-backup.db
   ```

## How It Works

### CUE-Based Configuration

**All configuration is in `../machines/machines.cue`:**

```cue
// Define common patches (applied to multiple nodes)
commonPatches: {
  kubeletCert: #Patch & {
    machine: kubelet: {
      certSANs: ["k8s-api.joshcorp.co"]
    }
  }
}

// Define hardware-specific patches
hardwarePatches: {
  x86disk: #Patch & {
    machine: install: {
      disk: "/dev/sdb"
      wipe: true
    }
  }
}

// Define node-specific patches
nodePatches: {
  cherry: #Patch & {
    machine: {
      install: disk: "/dev/mmcblk0"
      network: hostname: "cherry"
    }
  }
}

// Compose node definitions from patches
nodes: {
  cherry: #Node & {
    role: "worker"
    patches: [
      commonPatches.kubeletCert,
      commonPatches.kubeletIP,
      commonPatches.austinLabels,
      kubespanEnabled,
      hardwarePatches.sdcardInstall,
      hardwarePatches.ephemeralUSB,  // optional
      nodePatches.cherry,
    ]
  }
}
```

### Configuration Pipeline

1. **Secrets:** `get-or-create-secrets.sh` fetches/creates `result/secrets.yaml` from Doppler
2. **Base configs:** `talosctl gen config --with-secrets` generates standard `controlplane.yaml` and `worker.yaml`
3. **CUE patches:** `machines.cue` defines minimal patches (only what differs from Talos defaults)
4. **Type checking:** Patches are validated against Talos v1alpha1 schema from `cue.mod/gen/`
5. **Merge:** `talosctl machineconfig patch` applies patches to base configs
6. **Output:** Final configs in `result/<node>.yaml` ready for `talosctl apply-config`

### Type Safety

```bash
# Validate all patches against Talos schema
cd ../machines
cue vet .
```

CUE catches errors before deployment:
- Field name typos (e.g., `validSubnet` → `validSubnets`)
- Type mismatches (e.g., number instead of string)
- Invalid configuration values
- Schema violations

### Makefile Targets

| Target | Description |
|--------|-------------|
| `make secrets` | Fetch/create secrets from Doppler |
| `make configs` | Generate all node configurations |
| `make validate NODE=<name>` | Validate a specific node config |
| `make apply NODE=<name>` | Apply config to a node |
| `make bootstrap NODE=<name>` | Bootstrap cluster (once) |
| `make clean` | Clean generated configs |

## Troubleshooting

### Node Won't Boot

**Symptoms:** Node stuck at boot, no network, no Talos dashboard

**Solutions:**
- Verify boot media integrity (re-flash USB/SD card)
- Check BIOS/UEFI boot order
- For Raspberry Pi: Ensure SD card is formatted correctly
- Add network drivers via Image Factory system extensions

### Node Can't Get IP Address

**Symptoms:** Node shows "waiting for network" or no IP assigned

**Solutions:**
- Check DHCP server is running and has available leases
- Verify network cable connection
- Check switch port status
- Add network drivers to Image Factory schematic
- Check kernel messages: `talosctl dmesg --nodes <ip>`

### Config Apply Fails

**Symptoms:** `make apply NODE=x` returns errors

**Solutions:**
- Verify node is running Talos: `talosctl version --insecure --nodes <ip>`
- Check node IP is correct in `machines.cue`
- Use `--insecure` flag if node hasn't been configured yet
- Validate config first: `make validate NODE=x`

### Bootstrap Fails

**Symptoms:** `make bootstrap` hangs or errors

**Solutions:**
- Ensure control plane config was applied successfully
- Wait 2-3 minutes after applying config before bootstrapping
- Check etcd isn't already running: `talosctl service etcd status --nodes <ip>`
- Only run bootstrap ONCE and on ONE control plane node
- Check logs: `talosctl logs etcd --nodes <ip>`

### KubeSpan Peers Not Connecting

**Symptoms:** Nodes can't communicate, pods on different nodes can't reach each other

**Solutions:**
- Verify all nodes have KubeSpan enabled in config
- Check Sidero Labs discovery service connectivity
- Ensure firewall allows WireGuard traffic
- Check peer status: `talosctl get kubespanpeerstatus --nodes <ip>`
- Verify node IPs are correct in `machines.cue`

### DNS Resolution Fails for k8s-api.joshcorp.co

**Symptoms:** Can't reach API server, `kubectl` times out

**Solutions:**
- Verify DNS A record exists and resolves correctly
- Update `/etc/hosts` as temporary workaround: `<control-plane-ip> k8s-api.joshcorp.co`
- Check API server cert SANs include the DNS name
- Use IP directly as fallback: `kubectl --server=https://<ip>:6443`

### Pods Stuck in Pending

**Symptoms:** New pods don't schedule, stay in Pending state

**Solutions:**
- Check node status: `kubectl get nodes`
- Check node resources: `kubectl describe node <name>`
- Verify CNI is working (KubeSpan provides pod networking)
- Check for taints: `kubectl describe node <name> | grep -i taint`
- Review pod events: `kubectl describe pod <name>`

### Need to Reset a Node

**Complete node reset:**

```bash
talosctl reset --nodes <ip> --graceful=false --reboot
```

> **Warning:** This wipes all data from the node. You'll need to re-apply configuration afterward.

## Additional Resources

- [Talos Documentation](https://www.talos.dev/docs/)
- [Talos Image Factory](https://factory.talos.dev/)
- [CUE Language Specification](https://cuelang.org/docs/)
- [KubeSpan Documentation](https://www.talos.dev/docs/kubernetes-guides/network/kubespan/)
- [Sidero Labs GitHub](https://github.com/siderolabs)

## Where to Update

**All configuration is in `../machines/machines.cue`**.

To modify the cluster:
1. Edit `machines/machines.cue`
2. Run `make configs` to regenerate
3. Validate with `make validate NODE=<name>`
4. Apply with `make apply NODE=<name>`

Never edit generated YAML files in `talos/result/` directly - they will be overwritten.
