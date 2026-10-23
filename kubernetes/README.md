[![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_pods_running&&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_node_count&label=Nodes&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_uptime_days&label=Uptime&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![CPU](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_cpu_usage&&logo=kubernetes&label=CPU&color=black)](https://kubernetes.io/)&nbsp;
[![RAM](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_memory_usage&&logo=kubernetes&label=RAM&color=black)](https://kubernetes.io/)&nbsp;
[![Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fkubernetes_version&label=Kubernetes&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Ftalos_version&&logo=talos&color=black)](https://kubernetes.io/)&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fflux_version&&logo=flux&color=black)](https://kubernetes.io/)&nbsp;
[![Alerts](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.iac.gg%2Fcluster_alert_count&&logo=prometheus)](https://kubernetes.io/)&nbsp;

Bare-metal cluster on 3 Lenovo P330 Tiny's (i7-9700, 64GB RAM each) running Talos Linux.

## ☁️ Core Components

- **[cert-manager](https://cert-manager.io/)** - Certificate management and Let's Encrypt integration
- **[cilium](https://github.com/cilium/cilium)** - eBPF-based networking, security, and observability
- **[rook-ceph](https://github.com/rook/rook)** - Distributed storage system providing block, object, and file storage with Ceph
- **[envoy-gateway](https://gateway.envoyproxy.io/)** - Ingress controller for routing and load balancing
- **[prometheus](https://prometheus.io/)** - Monitoring and alerting, with Grafana for dashboards
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

[Flux](https://github.com/fluxcd/flux2) watches the [kubernetes](./) folder and applies everything defined here to the cluster. Git is the single source of truth.

Each app in [kubernetes/apps](./apps) has a `kustomization.yaml` that defines its namespace and Flux `Kustomization` resources, which then manage `HelmRelease` or other Kubernetes objects.

[Renovate](https://github.com/renovatebot/renovate) automatically scans for dependency updates, opens pull requests, and once merged, Flux applies the changes to the cluster.
