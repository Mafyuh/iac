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
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
  }
}

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.69.1"
    }
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

module "proxmox" {
  source = "./proxmox"

  virtual_environment_endpoint = var.virtual_environment_endpoint
  virtual_environment_api = var.virtual_environment_api
  arrbuntu_ip_address = var.arrbuntu_ip_address
  vlan_gateway = var.vlan_gateway
  downloaders_ip_address = var.downloaders_ip_address
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  prox_ip_address = var.prox_ip_address
  npm_ip_address = var.npm_ip_address
  init_username = var.init_username
  init_password = var.init_password
  kasm_ip = var.kasm_ip
  kasm_ssh_ip = var.kasm_ssh_ip
  ubu_ip_address = var.ubu_ip_address
  pve2_ip_address = var.pve2_ip_address
  s3_endpoint = var.s3_endpoint
  aws_secret_access_key = var.aws_secret_access_key
  aws_access_key_id = var.aws_access_key_id
}