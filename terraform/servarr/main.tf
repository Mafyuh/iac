terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "arr.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "3.4.1"
    }
    prowlarr = {
      source  = "devopsarr/prowlarr"
      version = "3.2.0"
    }
    radarr = {
      source  = "devopsarr/radarr"
      version = "2.3.4"
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
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
}

provider "sonarr" {
  url     = "http://sonarr-app.arr.svc.cluster.local:8989"
  api_key = data.bitwarden-secrets_secret.sonarr_api_key.value
}

provider "radarr" {
  url     = "http://radarr-app.arr.svc.cluster.local:7878"
  api_key = data.bitwarden-secrets_secret.radarr_api_key.value
}

provider "prowlarr" {
  url     = "http://prowlarr-app.arr.svc.cluster.local:6767"
  api_key = data.bitwarden-secrets_secret.prowlarr_api_key.value
}
