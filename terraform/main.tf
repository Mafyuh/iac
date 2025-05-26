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
# backend "remote" {
#     hostname = "mafyuh.scalr.io"
#     organization = "Environment-A"

#     workspaces {
#       name = "IaC"
#     }
#   }
# }

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
  domains = var.domains
}

module "twingate" {
  source = "./twingate"
}

module "authentik" {
  source = "./authentik"
  domains = var.domains
}

module "unifi" {
  source = "./unifi"
}

# module "pfsense" {
#   source = "./pfsense"
# }

# module "github" {
#   source = "./github"
# }