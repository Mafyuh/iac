[![CD](https://github.com/Mafyuh/iac/actions/workflows/CD.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/CD.yml)
[![Ansible](https://github.com/Mafyuh/iac/actions/workflows/ansible-playbooks.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/ansible-playbooks.yml)

[![Pods](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_pods_running&&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Nodes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_node_count&label=Nodes&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Uptime](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_uptime_days&label=Uptime&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![CPU](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_cpu_usage&&logo=kubernetes&label=CPU&color=black)](https://kubernetes.io/)&nbsp;
[![RAM](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_memory_usage&&logo=kubernetes&label=RAM&color=black)](https://kubernetes.io/)&nbsp;
[![Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fkubernetes_version&label=Kubernetes&logo=kubernetes&color=black)](https://kubernetes.io/)&nbsp;
[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Ftalos_version&&logo=talos&color=black)](https://kubernetes.io/)&nbsp;
[![PVE Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fpve_version&&logo=proxmox&color=black)](https://kubernetes.io/)&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fflux_version&&logo=flux&color=black)](https://kubernetes.io/)&nbsp;
[![Alerts](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.mafyuh.dev%2Fcluster_alert_count&&logo=prometheus)](https://kubernetes.io/)&nbsp;

![Header Image](https://raw.githubusercontent.com/Mafyuh/homelab-svg-assets/main/assets/header_.png)

<div align="center">

# iac (wip)

This is my homelab infrastructure, defined in code.

</div>

---

<div align="center">

| Hypervisor                                                                                      | OS                                                                                                                                                                                                                                                                                                        | Tools                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Networking                                                                                              | Misc. Automations                                                                                                                                                                                      |
| ----------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [![Proxmox](https://img.shields.io/badge/-Proxmox-black?logo=Proxmox)](https://www.proxmox.com) | [![Talos](https://img.shields.io/badge/Talos-black?&logo=talos)](https://www.talos.dev/) [![Ubuntu](https://img.shields.io/badge/Ubuntu-black?&logo=ubuntu&logoColor=red)](https://releases.ubuntu.com/noble/) [![Arch](https://img.shields.io/badge/Arch-black?&logo=archlinux)](https://archlinux.org/) | [![Docker](https://img.shields.io/badge/-Docker-black?logo=docker)](https://www.docker.com/) [![Kubernetes](https://img.shields.io/badge/-Kubernetes-black?logo=kubernetes)](https://k3s.io/) [![Renovate](https://img.shields.io/badge/-Renovate-black?logo=renovate&logoColor=blue)](https://github.com/renovatebot/renovate) [![OpenTofu](https://img.shields.io/badge/-OpenTofu-black?logo=opentofu)](https://opentofu.org/) [![Packer](https://img.shields.io/badge/-Packer-black?logo=packer)](https://www.packer.io/) [![Ansible](https://img.shields.io/badge/-Ansible-black?logo=ansible&logoColor=red)](https://www.ansible.com/) [![Flux](https://img.shields.io/badge/-Flux-black?logo=flux)](https://fluxcd.io/) | [![Unifi](https://img.shields.io/badge/-Unifi-black?logo=ubiquiti&logoColor=blue)](https://www.ui.com/) | [![n8n](https://img.shields.io/badge/-n8n-black?logo=n8n)](https://n8n.io/) [![Actions](https://img.shields.io/badge/-Actions-black?logo=github&logoColor=white)](https://github.com/features/actions) |

</div>

## 📖 **Overview**

This repository contains the IaC ([Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code)) configuration for my homelab.

Most of my homelab runs on **Proxmox**, with VMs managed and maintained using [OpenTofu](https://opentofu.org/). All VMs are cloned from templates I created with [Packer](https://www.packer.io/).

All services are **containerized**, either managed with **Docker Compose** or **orchestrated with Kubernetes**. Over time, I've been migrating everything to Kubernetes using **[GitOps](https://en.wikipedia.org/wiki/DevOps) practices**, which is my long-term goal.

To automate infrastructure updates, I use **Github Actions**, which trigger workflows upon changes to this repo. This ensures seamless deployment and maintenance across my homelab:

- **[Flux](https://fluxcd.io/)** manages Continuous Deployment (CD) for Kubernetes, deployed via [Flux Operator](https://fluxcd.control-plane.io/).
- **[Docker CD Workflow](https://github.com/Mafyuh/iac/blob/main/.github/workflows/CD.yml)** handles Continuous Deployment for Docker services.
- **[Renovate](https://github.com/renovatebot/renovate)** keeps services updated by opening PRs for new versions.
- **[Ansible](https://github.com/ansible/ansible)** is used to execute playbooks on all of my VMs, automating management and configurations

### 🔒 **Security & Networking**

For Secret management I use [Bitwarden Secrets](https://bitwarden.com/products/secrets-manager/) and their various [integrations](https://bitwarden.com/help/ansible-integration/) into the tools used.

> Kubernetes is using External Secrets implementation of BWS, not official. BWS Access Key is SOPS encrypted.

**[GitGuardian](https://www.gitguardian.com/)** makes sure to alert me if I do accidentally push a secret

Each container image is automatically scanned by **[Trivy](https://trivy.dev/latest/)**, with detected vulnerabilities published to **[Github Security](https://github.com/security)**

I use **Oracle Cloud** for their [Always-Free](https://www.oracle.com/cloud/free/) VM's and deploy Docker services that require uptime here. [Twingate](https://www.twingate.com/) is used to connect my home network to the various VPS's securely using [Zero Trust architecture](https://en.wikipedia.org/wiki/Zero_trust_architecture).

I use [**Cloudflare**](https://www.cloudflare.com/) for my DNS provider with [**Cloudflare Tunnels**](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) to expose some of the services to the world. [**Cloudflare Access**](https://www.cloudflare.com/access/) is used as Zero Trust for public websites, this is paired with [**Fail2Ban**](https://www.fail2ban.org/) looking through all my reverse proxy logs for malicious actors who made it through [**Access**](https://www.cloudflare.com/access/) and banning them via [**Cloudflare WAF**](https://www.cloudflare.com/web-application-firewall/).

I also utilize Unifi's IDS/IPS for intrusion detection on my home network, and use **[Wazuh](https://wazuh.com/)** as a SIEM to monitor and generate security alerts across all my hosts.

### **📊 Monitoring & Observability**

I use a combination of **Grafana, Loki, Alloy, and Prometheus** with various exporters to collect and visualize system metrics, logs, and alerts. This helps maintain visibility into my infrastructure and detect issues proactively.

- **Prometheus** – Metrics collection and alerting
- **Loki** – Centralized logging for containers and VMs
- **Grafana** – Dashboarding and visualization
- **Exporters** – Alloy, Blackbox Exporter, Speedtest Exporter, etc.

### ☁️ **Cloud Dependencies**

Although I try to self-host everything I can, my infra still relies on the cloud for certain services.

| Service                                                                                 | Use                                                                                                             | Cost           |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | -------------- |
| [Proton](https://proton.me/)                                                            | IMAP, SMTP, VPN (Pass once there is Autofill Hotkey)                                                            | ~$120/yr       |
| [Bitwarden](https://bitwarden.com/)                                                     | Secrets for all tools                                                                                           | Free           |
| [OneDrive](https://www.microsoft.com/en-us/microsoft-365/onedrive/online-cloud-storage) | Takes backups of Proxmox VM's, Kubernetes PV's (will migrate to Proton Drive once there's proper Linux support) | Free (e5 dev)  |
| [Cloudflare](https://www.cloudflare.com/)                                               | Domain, DNS, WAF                                                                                                | Free           |
| [GitHub](https://github.com/)                                                           | Hosting this repo and continuous integration/deployments                                                        | Free           |
| [Oracle Cloud](https://www.oracle.com/cloud/)                                           | ARM Cloud VM, services such as Uptime Kuma, Vaultwarden                                                         | ~$5/month      |
|                                                                                         |                                                                                                                 | Total: ~$15/mo |

## 🧑‍💻 **Getting Started**

This repo is not structured like a project you can easily replicate. Although if you are new to any of the tools used I encourage you to read through the directories that make up each tool to see how I am using them.

Over time I will try to add more detailed instructions in each directories README.

Some good references for how I learned this stuff (other than RTFM)

- [Kubernetes Cluster Setup](https://technotim.live/posts/k3s-etcd-ansible/)
- [Kubernetes + Flux](https://technotim.live/posts/flux-devops-gitops/)
- [Kubernetes Secrets with SOPS](https://technotim.live/posts/secret-encryption-sops/)
- [Finding Kubernetes HelmReleases](https://kubesearch.dev)
- [Packer with Proxmox](https://www.youtube.com/watch?v=1nf3WOEFq1Y)
- [Terraform with Proxmox](https://www.youtube.com/watch?v=dvyeoDBUtsU)
- [Docker](https://www.youtube.com/watch?v=eGz9DS-aIeY)
- [Ansible](https://www.youtube.com/watch?v=goclfp6a2IQ)

## 🖥️ **Hardware**

Proof that you don't need expensive new equipment to run infra like mine. Mostly everything here is secondhand, bought over time, totaling less than ~$3k.

<details open>
  <summary><strong>Servers</strong></summary>

| Name                      | Device                                                                                                                | CPU            | RAM        | Storage                                    | GPU              | Purpose                         |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------------------------------------------ | ---------------- | ------------------------------- |
| **Talos-1**               | Optiplex 7040 Micro                                                                                                   | Intel i5-6500t | 32GB DDR4  | 1x1TB SATA SSD 128GB NVME                  | Integrated       | k8s control-plane               |
| **Talos-2**               | Optiplex 7040 Micro                                                                                                   | Intel i5-6500t | 32GB DDR4  | 1x1TB SATA SSD 128GB NVME                  | Integrated       | k8s control-plane               |
| **Talos-3**               | Optiplex 7040 Micro                                                                                                   | Intel i5-6500t | 32GB DDR4  | 1x1TB SATA SSD 128GB NVME                  | Integrated       | k8s control-plane               |
| **Arc-Ripper**            | Optiplex 3050                                                                                                         | Intel i5-6500  | 32 GB DDR4 | 1TB NVMe                                   | Arc A310         | Jellyfin Server, Blu-ray Ripper |
| **PVE Node 1**            | Custom                                                                                                                | Intel i7-9700K | 64 GB DDR4 | NVMe for boot and VMs, 4×4TB HDD (RaidZ10) | Nvidia 1660 6GB  | Main node with most VMs, NAS    |
| **PVE Node 2**            | Custom                                                                                                                | Intel i7-8700K | 64 GB DDR4 | 1×2TB NVMe                                 | Nvidia 3080 10GB | More VMs                        |
| **Pi**                    | Raspberry Pi 4                                                                                                        |                | 8GB        | 1TB m.2 SATA SSD w/ USB HAT                | n/a              | Home Assistant Server           |
| **Proxmox Backup Server** | [Mini-PC](https://www.amazon.com/FIREBAT-Computer-Expansible-Efficient-Business/dp/B0DZWP653T/ref=sr_1_4?s=pc&sr=1-4) | Intel N150     | 8GB        | 2TB SATA                                   | n/a              | Backup Proxmox VM's             |

</details>

<details>
  <summary><strong>Personal</strong></summary>

| Name      | Device         | CPU               | RAM       | Storage   | GPU             | Purpose               |
| --------- | -------------- | ----------------- | --------- | --------- | --------------- | --------------------- |
| Gaming PC | Custom         | Intel i7-13700k   | 64GB DDR5 | 10TB NVMe | Nvidia RTX 5070 | Main Machine          |
| Laptop    | HP 15-eh1097nr | AMD Ryzen 7 5700U | 32GB DDR4 | 1TB NVMe  | Integrated      | On the go/bed machine |

</details>

<details>
  <summary><strong>Networking</strong></summary>

| Name   | Device                                                                                                 | Purpose         |
| ------ | ------------------------------------------------------------------------------------------------------ | --------------- |
| Switch | [Unifi Flex 2.5Gb PoE](https://store.ui.com/us/en/category/all-switching/products/usw-flex-2-5g-8-poe) | Switch with PoE |
| Router | [Unifi Dream Router 7](https://store.ui.com/us/en/products/udr7)                                       | Router/Firewall |
| AP     | [U7 Pro XG](https://store.ui.com/us/en/category/all-wifi/products/u7-pro-xg)                           | AP              |

</details>

## 📌 **To-Do**

See [Project Board](https://github.com/users/Mafyuh/projects/1)
