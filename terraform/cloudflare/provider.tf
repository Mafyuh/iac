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
      version = "5.15.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}

provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  project_id      = "5afc4f45-6422-4373-96cb-b2080005bf71"
}

provider "cloudflare" {
  # api_token = data.bitwarden-secrets_secret.cloudflare_api_token.value
  api_key = data.bitwarden-secrets_secret.cloudflare_api_key.value
  email   = "matt@mafyuh.dev"
}
