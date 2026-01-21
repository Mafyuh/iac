terraform {
  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "proxmox.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.93.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}

provider "proxmox" {
  endpoint      = "https://prox.mafyuh.xyz/"
  api_token     = data.bitwarden-secrets_secret.prox_api_key.value
  insecure      = false
  random_vm_ids = true
  ssh {
    agent = true
    ## TODO: stop using root
    username = "root"
    password = data.bitwarden-secrets_secret.ssh_password.value

    node {
      name    = "prox"
      address = data.bitwarden-secrets_secret.prox_ip_address.value
    }

    node {
      name    = "pve2"
      address = data.bitwarden-secrets_secret.pve2_ip_address.value
    }
  }
}

provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
}
