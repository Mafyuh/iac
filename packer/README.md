How the Packer Templates are Used:

1. Ubuntu Cloud Image is downloaded to Proxmox via Tofu in [`images.tf`](../terraform/proxmox/images.tf)
2. Since Packer's `proxmox-iso` doesn't support `.img` file extensions, we first create a bare-bones base image for Packer to clone in [`plucky_base.tf`](../terraform/proxmox/plucky_base.tf)
3. Cloud Init for this base image installs `qemu-guest-agent` which is needed for various automation's to work from [`cloud-init.tf`](../terraform/proxmox/cloud-init.tf)
4. Once Tofu templates base image, Packer is ran to clone it using `proxmox-clone`, executes [`setup-ubuntu.sh`](ubuntu/files/setup-ubuntu.sh) to setup the OS, it also clears all information on the VM so it can spin up with a new seed and MAC and HW ID in [`plucky.pkr.hcl`](ubuntu/plucky/plucky.pkr.hcl) 
5. Once this is new VM is templated, it is cloned to all future VM's. This process is duplicated for both Proxmox nodes I have. All of which are IaC in [`terraform/`](../terraform)

Debian image is for Kubernetes hosts as I wanted a stable OS with minimal modifications.

## Commands
### Validate & Build
in `iac/packer`
```bash
packer validate -var-file=credentials.pkr.hcl ubuntu/plucky/plucky.pkr.hcl
```
```bash
packer build -var-file=credentials.pkr.hcl ubuntu/plucky/plucky.pkr.hcl
```
