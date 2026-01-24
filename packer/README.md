How the Packer Templates are Used:

1. Ubuntu server is downloaded via Terraform [here](../terraform/proxmox/images.tf).
2. Packer uses this iso to create a template, the packer config is [here](/packer/ubuntu/noble/noble.pkr.hcl)
3. Once this is new VM is templated, it is cloned to all future VM's. This process is duplicated for both Proxmox nodes I have. All of which are IaC in [`terraform/`](../terraform)

## Commands

### Validate & Build

in `iac/packer`

```bash
packer validate -var-file=credentials.pkr.hcl ubuntu/plucky/plucky.pkr.hcl
```

```bash
packer build -var-file=credentials.pkr.hcl ubuntu/plucky/plucky.pkr.hcl
```
