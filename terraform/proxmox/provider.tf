terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.1"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
  }
}