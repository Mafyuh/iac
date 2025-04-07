terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.74.1"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
  }
}