[![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_pods_running&&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_node_count&label=Nodes&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_uptime_days&label=Uptime&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![CPU](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_cpu_usage&&logo=kubernetes&label=CPU&color=blue)](https://kubernetes.io/)&nbsp;
[![RAM](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_memory_usage&&logo=kubernetes&label=RAM&color=blue)](https://kubernetes.io/)&nbsp;
[![Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fkubernetes_version&label=Kubernetes&logo=kubernetes&color=blue)](https://kubernetes.io/)&nbsp;
[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Ftalos_version&&logo=talos&color=blue)](https://kubernetes.io/)&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fflux_version&&logo=flux&color=blue)](https://kubernetes.io/)&nbsp;

Physical cluster on 3 Optiplex 7040 Micro's with Talos OS.

## ☁️ Core Components
* **[cert-manager](https://cert-manager.io/)**
* **[cilium](https://github.com/cilium/cilium)**
* **[longhorn](https://longhorn.io/)**
* **[NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/)**
* **[sops](https://toolkit.fluxcd.io/guides/mozilla-sops/)**

### Cluster Setup
```bash
kubectl create ns flux-system
kubectl -n flux-system create secret generic sops-age --from-file=age.agekey=/home/$USER/.sops/key.txt
```
[Flux is bootstrapped via OpenTofu](https://github.com/Mafyuh/iac/blob/main/terraform/flux/main.tf) and once above commands are run Flux then takes over and reconciles to match Git

## 🗃️ Folder Structure
```shell
kubernetes
├── 📁 apps                        # Application deployments
│   ├── 📁 arr                     # Media stack
│   └── 📁 other applications      # Various containerized services
├── 📁 cluster                     # Flux + cluster-level config
│   └── 📁 production
│       ├── 📁 charts             # Helm chart sources
│       ├── 📁 flux-system        # Flux bootstrapping
│       └── 📁 namespaces         # Cluster namespaces
├── 📁 secrets                     # SOPS-encrypted secrets
├── 📁 talos                      # Talos OS configuration
└── README.md

```