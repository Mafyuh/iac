<div align="center">

# OpenTofu / Terraform

</div>

This folder contains predefined configuration files that OpenTofu uses to manage infrastructure.

OpenTofu reads these files, connects to various providers through their APIs, and ensures the real-world infrastructure matches the desired state defined in code.

I'm currently in the **import phase**, where I’m bringing pre-existing infrastructure into OpenTofu’s state. This process involves a lot of manually querying APIs, finding resource IDs, and importing each component one by one.

Because of this, many services are **not yet fully managed through IaC**, but the goal is to eventually have everything defined and reproducible through code.

---
## Overview

OpenTofu's state file is stored in Oracle S3 for easy multiple machine access.



