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
