terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.3"
    }
  }

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
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
  }
}

provider "proxmox" {
  endpoint = var.virtual_environment_endpoint
  password = var.ssh_password
  username = "root@pam"
  insecure = true

  ssh {
    agent = true
    username = "root"
    password = var.ssh_password

    node {
      name    = "prox"
      address = var.prox_ip_address
    }

    node {
      name    = "pve2"
      address = var.pve2_ip_address
    }
  }
}
