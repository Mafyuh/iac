terraform {
  required_version = ">= 1.0.0"


backend "s3" {
    bucket                        = "tofu"
    region                        = "us-east-1"
    key                           = "tf.tfstate"
    endpoint                      = "https://s3.mafyuh.xyz"
    skip_region_validation        = true
    skip_credentials_validation   = true
    skip_requesting_account_id    = true
    use_path_style                = true
    skip_s3_checksum              = true
    skip_metadata_api_check       = true
  }
}

# module "proxmox" {
#   source = "./proxmox"
  
#   providers = {
#     proxmox = proxmox
#   }
# }

module "flux" {
  source = "./flux"
}

module "oci" {
  source = "./oracle"
}

module "cloudflare" {
  source = "./cloudflare"
  domains = var.domains
}

module "twingate" {
  source = "./twingate"
}

# module "authentik" {
#   source = "./authentik"
#   domains = var.domains
# }

# module "unifi" {
#   source = "./unifi"
# }

# module "pfsense" {
#   source = "./pfsense"
# }

# module "github" {
#   source = "./github"
# }