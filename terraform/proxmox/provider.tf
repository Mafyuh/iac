terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.6"
    }
  }
}