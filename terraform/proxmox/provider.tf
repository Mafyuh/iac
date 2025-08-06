terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.81.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.15.0"
    }
  }
}