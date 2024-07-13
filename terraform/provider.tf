terraform {

    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = ">= 0.60.1"
        }
    }
}

provider "proxmox" {
  endpoint  = var.virtual_environment_endpoint
  password  = var.ssh_password
  username  =  "root@pam"
  insecure  = true
  
  ssh {
    agent = true
    username  = "root"
    password  = var.ssh_password
    node {
        name    = "prox"
        address = var.prox_ip_address
    }
  }
}
