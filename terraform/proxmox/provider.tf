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
      version = "0.91.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}

provider "proxmox" {
  endpoint      = "https://prox.mafyuh.xyz/"
  api_token     = data.bitwarden_secret.prox_api_key.value
  insecure      = false
  random_vm_ids = true
  ssh {
    agent = true
    ## TODO: stop using root
    username = "root"
    password = data.bitwarden_secret.ssh_password.value

    node {
      name    = "prox"
      address = data.bitwarden_secret.prox_ip_address.value
    }

    node {
      name    = "pve2"
      address = data.bitwarden_secret.pve2_ip_address.value
    }
  }
}

provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}
