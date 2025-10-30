terraform {
  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "cloudflare.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.12.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}

provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}

provider "cloudflare" {
  # api_token = data.bitwarden_secret.cloudflare_api_token.value
  api_key = data.bitwarden_secret.cloudflare_api_key.value
  email   = "matt@mafyuh.dev"
}
