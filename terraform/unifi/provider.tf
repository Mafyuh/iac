terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "unifi.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.12"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}

provider "unifi" {
  username       = "terraform"
  password       = data.bitwarden-secrets_secret.unifi_password.value
  api_url        = "https://10.0.0.1"
  allow_insecure = "true"
}

provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
}
