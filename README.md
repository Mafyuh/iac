[![Yamllint](https://github.com/Mafyuh/iac/actions/workflows/yamllint.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/yamllint.yml)
[![CD](https://github.com/Mafyuh/iac/actions/workflows/CD.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/CD.yml)
[![Ansible](https://github.com/Mafyuh/iac/actions/workflows/ansible-playbooks.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/ansible-playbooks.yml)
[![Tofu](https://github.com/Mafyuh/iac/actions/workflows/tofu.yml/badge.svg)](https://github.com/Mafyuh/iac/actions/workflows/tofu.yml)


[![Running Pods](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_pods_running&label=Running%20Pods&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
[![Uptime](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_uptime_days&label=Uptime&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
[![Memory](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_memory_usage&style=flat-square&label=Memory&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
[![Nodes](https://img.shields.io/endpoint?url=https://prom-metrics.mafyuh.dev/cluster_node_count&label=Nodes&color=blue&logo=kubernetes)](https://github.com/mafyuh/iac)
![Header Image](https://raw.githubusercontent.com/Mafyuh/homelab-svg-assets/main/assets/header_.png)


<div align="center">

# iac (wip)

This is my homelab infrastructure, defined in code.

</div>

---



<div align="center">

| Hypervisor | OS | Tools | Firewall | Misc. Automations |
|---|---|---|---|---|
| [![Proxmox](https://img.shields.io/badge/-Proxmox-%23c9d1d9?logo=Proxmox)](https://www.proxmox.com) | [![Debian](https://img.shields.io/badge/Debian-%23c9d1d9?&logo=debian&logoColor=black)](https://www.debian.org/) [![Ubuntu](https://img.shields.io/badge/Ubuntu-%23c9d1d9?&logo=ubuntu&logoColor=red)](https://releases.ubuntu.com/noble/) | [![Docker](https://img.shields.io/badge/-Docker-%23c9d1d9?logo=docker)](https://www.docker.com/) [![Kubernetes](https://img.shields.io/badge/-Kubernetes-%23c9d1d9?logo=kubernetes)](https://k3s.io/) [![Renovate](https://img.shields.io/badge/-Renovate-%23c9d1d9?logo=renovate&logoColor=blue)](https://github.com/renovatebot/renovate) [![OpenTofu](https://img.shields.io/badge/-OpenTofu-%23c9d1d9?logo=opentofu)](https://opentofu.org/) [![Packer](https://img.shields.io/badge/-Packer-%23c9d1d9?logo=packer)](https://www.packer.io/) [![Ansible](https://img.shields.io/badge/-Ansible-%23c9d1d9?logo=ansible&logoColor=red)](https://www.ansible.com/) | [![pfSense](https://img.shields.io/badge/-pfSense-%23c9d1d9?logo=pfsense&logoColor=blue)](https://www.pfsense.org/) | [![n8n](https://img.shields.io/badge/-n8n-%23c9d1d9?logo=n8n)](https://n8n.io/) [![Actions](https://img.shields.io/badge/-Actions-%23c9d1d9?logo=github&logoColor=black)](https://github.com/features/actions)

</div>

## 📖 **Overview**
This repository contains the IaC ([Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code)) configuration for my homelab.  

Most of my homelab runs on **Proxmox**, with VMs managed and maintained using [OpenTofu](https://opentofu.org/). All VMs are cloned from templates I created with [Packer](https://www.packer.io/).  

All services are **containerized**, either managed with **Docker Compose** or **orchestrated with Kubernetes ([K3s](https://k3s.io/))**. Over time, I’ve been migrating everything to Kubernetes using **[GitOps](https://en.wikipedia.org/wiki/DevOps) practices**, which is my long-term goal.  

To automate infrastructure updates, I use **Github Actions**, which trigger workflows upon changes to this repo. This ensures seamless deployment and maintenance across my homelab:  

- **[Flux](https://fluxcd.io/)** manages Continuous Deployment (CD) for Kubernetes, bootstrapped via [OpenTofu](https://github.com/Mafyuh/iac/blob/main/terraform/flux/main.tf).
- **[Docker CD Workflow](https://github.com/Mafyuh/iac/blob/main/.github/workflows/CD.yml)** handles Continuous Deployment for Docker services.   
- **[Renovate](https://github.com/renovatebot/renovate)** keeps services updated by opening PRs for new versions.  
- **[Yamllint](https://github.com/adrienverge/yamllint)** ensures configuration files are properly structured.
- **[Ansible](https://github.com/ansible/ansible)** is used to execute playbooks on all of my VMs, automating management and configurations

### 🔒 **Security & Networking**
For Secret management I use [Bitwarden Secrets](https://bitwarden.com/products/secrets-manager/) and their various [integrations](https://bitwarden.com/help/ansible-integration/) into the tools used.
> Kubernetes is using SOPS with Age encryption until migration over to Bitwarden Secrets.

I use **Oracle Cloud** for their [Always-Free](https://www.oracle.com/cloud/free/) VM's and deploy Docker services that require uptime here (Uptime Kuma, this website). [Twingate](https://www.twingate.com/) is used to connect my home network to the various VPS's securely using [Zero Trust architecture](https://en.wikipedia.org/wiki/Zero_trust_architecture).

I use **Cloudflare** for my DNS provider with **Cloudflare Tunnels** to expose some of the services to the world. **Cloudflare Access** is used to restrict the access to some of the services, this is paired with **Fail2Ban** looking through all my reverse proxy logs for malicious actors who made it through **Access** and banning them via **Cloudflare WAF**.

For my home network I use **PfSense** with VLAN segmentation and strict firewall rules to isolate public-facing machines, ensuring they can only communicate with the necessary services and nothing else.

### **📊 Monitoring & Observability**  
I use a combination of **Grafana, Loki, and Prometheus** with various exporters to collect and visualize system metrics, logs, and alerts. This helps maintain visibility into my infrastructure and detect issues proactively.  

- **Prometheus** – Metrics collection and alerting  
- **Loki** – Centralized logging for containers and VMs  
- **Grafana** – Dashboarding and visualization  
- **Exporters** – Node Exporter, cAdvisor, Blackbox Exporter, etc.  

## 🧑‍💻 **Getting Started**
This repo is not structured like a project you can easily replicate. Although if you are new to any of the tools used I encourage you to read through the directories that make up each tool to see how I am using them.

Over time I will try to add more detailed instructions in each directories README.

Some good references for how I learned this stuff (other than RTM)
- [Kubernetes Cluster Setup](https://technotim.live/posts/k3s-etcd-ansible/)
- [Kubernetes + Flux](https://technotim.live/posts/flux-devops-gitops/)
- [Kubernetes Secrets with SOPS](https://technotim.live/posts/secret-encryption-sops/)
- [Packer with Proxmox](https://www.youtube.com/watch?v=1nf3WOEFq1Y)
- [Terraform with Proxmox](https://www.youtube.com/watch?v=dvyeoDBUtsU)
- [Docker](https://www.youtube.com/watch?v=eGz9DS-aIeY)
- [Ansible](https://www.youtube.com/watch?v=goclfp6a2IQ)

## 🖥️ **Hardware**

| Name        | Device         | CPU             | RAM          | Storage                                      | GPU       | Purpose                          |
|-------------|----------------|-----------------|--------------|----------------------------------------------|-----------|----------------------------------|
| Arc-Ripper  | Optiplex 3050  | Intel i5-6500   | 32 GB DDR4   | 1TB NVMe                                     | Arc A310      | Jellyfin Server, Blu-ray Ripper |
| PVE Node 1  | Custom         | Intel i7-9700K  | 64 GB DDR4   | NVMe for boot and VMs, 4x4TB HDD RaidZ10     | Nvidia 1660 6GB      | Main node with most VMs, NAS    |
| PVE Node 2  | Custom         | Intel i7-8700K  | 64 GB DDR4   | 1x2TB NVMe                                   | Nvidia 1060 6GB      | More VMs                         |


## 📌 **To-Do**
See [Project Board](https://github.com/users/Mafyuh/projects/1)

