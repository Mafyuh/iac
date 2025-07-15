terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.80.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.14.0"
    }
  }
}