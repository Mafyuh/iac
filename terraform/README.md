<div align="center">

# Terraform

</div>

This folder contains predefined configuration files that Terraform uses to manage infrastructure.

Terraform reads these files, connects to various providers through their APIs, and ensures the real-world infrastructure matches the desired state defined in code.

I'm currently in the **import phase**, where I'm bringing pre-existing infrastructure into Terraform's state. This process involves a lot of manually querying APIs, finding resource IDs, and importing each component one by one.

Because of this, many services are **not yet fully managed through IaC**, but the goal is to eventually have everything defined and reproducible through code.

---

## Overview

[TF-Controller](https://flux-iac.github.io/tofu-controller/) allows me to GitOps-ify my Terraform deployments, it allows Flux in K8S to reconcile Terraform resources the same way it does the rest of my cluster

Terraform state files are stored in self-hosted Minio for easy multi-machine access and are backed up to OneDrive daily.
