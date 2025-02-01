terraform {
  required_version = ">= 1.0.0"


backend "s3" {
    bucket                      = "BigBuckets"
    region                      = "us-ashburn-1"
    key                         = "tf.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = var.s3_endpoint
    }
  }
}

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.1"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.4.0"
    }
  }
}

provider "bitwarden-secrets" {
  access_token = var.access_token
}


provider "proxmox" {
  endpoint = data.bitwarden-secrets_secret.virtual_environment_endpoint.value
  password = data.bitwarden-secrets_secret.ssh_password.value
  username = "root@pam"
  insecure = true

  ssh {
    agent = true
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

module "proxmox" {
  source = "./proxmox"
  
  providers = {
    proxmox = proxmox
  }
}

module "flux" {
  source = "./flux"
}
