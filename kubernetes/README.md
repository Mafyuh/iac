[![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_pods_running&&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_node_count&label=Nodes&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_uptime_days&label=Uptime&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![CPU](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_cpu_usage&&logo=kubernetes&label=CPU)](https://kubernetes.io/)&nbsp;
[![RAM](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_memory_usage&&logo=kubernetes&label=RAM)](https://kubernetes.io/)&nbsp;
[![Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fkubernetes_version&label=Kubernetes&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Ftalos_version&&logo=talos&color=blue)](https://kubernetes.io/)&nbsp;

Physical cluster on 3 Optiplex 7040 Micro's with Talos OS.

## ☁️ Core Components

- **[cert-manager](https://cert-manager.io/)** - Certificate management and Let's Encrypt integration
- **[cilium](https://github.com/cilium/cilium)** - eBPF-based networking, security, and observability
- **[rook-ceph](https://github.com/rook/rook)** - Distributed storage system providing block, object, and file storage with Ceph
- **[envoy-gateway](https://gateway.envoyproxy.io/)** - Ingress controller for routing and load balancing
- **[prometheus](https://prometheus.io/)** - Monitoring and alerting stack with Grafana Alloy
- **[external-secrets](https://external-secrets.io/latest/)** - Secrets pulled from Bitwarden Secrets.
- **[flux](https://fluxcd.io/)** - GitOps continuous delivery

### Cluster Setup

The cluster uses **Flux Operator** with a **Flux Instance** for GitOps. Once the below are executed Flux will reconcile the entire cluster to this repo.

```bash
kubectl create ns flux-system
kubectl -n flux-system create secret generic sops-age --from-file=age.agekey=/home/$USER/.sops/key.txt

helm repo add controlplaneio https://controlplaneio.github.io/charts
helm repo update

helm install flux-operator controlplaneio/flux-operator -n flux-system

kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=flux-operator -n flux-system --timeout=300s
kubectl apply -f kubernetes/flux/cluster.yaml
```

### GitOps

[Flux](https://github.com/fluxcd/flux2) watches the [kubernetes](./kubernetes) folder and applies everything defined here to the cluster. Git is the single source of truth.

Each app in [kubernetes/apps](./kubernetes/apps) has a `kustomization.yaml` that defines its namespace and Flux `Kustomization` resources, which then manage `HelmRelease` or other Kubernetes objects.

[Renovate](https://github.com/renovatebot/renovate) automatically scans for dependency updates, opens pull requests, and once merged, Flux applies the changes to the cluster.

### Backups & Restoration

The cluster uses a three-layer backup strategy ensuring zero data loss in case of complete infrastructure failure:

**Layer 1: Volsync + Snapshots**
[VolSync](https://github.com/backube/volsync) runs hourly snapshots of all PersistentVolumeClaims using Kopia as the backend. Each application defines a `ReplicationSource` resource that automatically captures point-in-time snapshots. Snapshots are retained for 24 hours (hourly) and 7 days (daily). Snapshots use Ceph's native snapshot capability via the `csi-ceph-blockpool` storage class for efficient, point-in-time recovery.

**Layer 2: Kopia Repository**
VolSync stores all snapshots in a centralized [Kopia](https://kopia.io/) repository mounted via NFS. Kopia handles deduplication, compression (zstd), and retention policies, allowing efficient long-term storage.

**Layer 3: Cloud Backup**
The NFS pool is backed up daily to OneDrive, providing off-site redundancy. This ensures that even if the entire homelab is destroyed, all cluster data can be restored.

**Recovery Process**
Complete cluster rebuild from bare metal to all apps fully operational with zero data loss: boot the machine, iPXE installs Talos, run the bootstrap command above, and Flux automatically restores everything including application data from Kopia snapshots. This takes approximately 10 minutes.
