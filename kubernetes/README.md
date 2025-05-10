[![Running Pods](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_pods_running&label=Running%20Pods&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
[![Uptime](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_uptime_days&label=Uptime&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
[![Nodes](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_node_count&label=Nodes&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)

Bootstrapped via Ansible using [k3s-ansible](https://technotim.live/posts/k3s-etcd-ansible/)(non-IaC currently), currently a virtual cluster but plan to migrate to physical.

## ☁️ Cluster Overview

* **[MetalLB](https://metallb.universe.tf/)**
* **[kube-vip](https://kube-vip.io/)**
* **[Flannel](https://github.com/flannel-io/flannel)**
* **[NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)**
* **[Longhorn](https://longhorn.io/)**
* **[cert-manager](https://cert-manager.io/)**


### Cluster Setup
```bash
kubectl create ns flux-system
kubectl -n flux-system create secret generic sops-age --from-file=age.agekey=/home/$USER/.sops/key.txt
```
[Flux is bootstrapped via OpenTofu](https://github.com/Mafyuh/iac/blob/main/terraform/flux/main.tf) and once above commands are run Flux then takes over and reconciles to match Git

## 🗃️ Folder Structure
Probably will change and I will forget to update this

```shell
kubernetes
├── 📁 apps                        # Application deployments
│   ├── 📁 production              # Production environment
│   │   ├── 📁 arr                 # Media stack (Sonarr, Radarr, etc.)
│   │   ├── 📁 other apps          # Other container images
│   └── 📁 staging                # Staging environment
├── 📁 cluster                     # Flux + cluster-level configuration
│   └── 📁 production
│       ├── 📁 charts             # Helm chart sources
│       ├── 📁 flux-system        # Flux bootstrapping
│       ├── 📁 namespaces         # Cluster namespaces
├── 📁 secrets                     # SOPS-encrypted secrets
├── kustomization.yaml            # Top-level entrypoint
└── README.md

```



