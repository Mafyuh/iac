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

module "proxmox" {
  source = "./proxmox"
  
  providers = {
    proxmox = proxmox
  }
}

module "flux" {
  source = "./flux"
}

module "oci" {
  source = "./oracle"
}

module "servarr" {
  source = "./servarr"
}

module "cloudflare" {
  source = "./cloudflare"
}
