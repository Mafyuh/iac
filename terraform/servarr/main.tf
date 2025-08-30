terraform {
  required_version = ">= 1.0.0"
  
  backend "s3" {
    bucket                        = "tofu"
    region                        = "us-east-1"
    key                           = "servarr.tfstate"
    endpoint                      = "https://s3.mafyuh.xyz"
    skip_region_validation        = true
    skip_credentials_validation   = true
    skip_requesting_account_id    = true
    use_path_style                = true
    skip_s3_checksum              = true
    skip_metadata_api_check       = true
  }

  required_providers {
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "3.4.0"
    }
    prowlarr = {
      source  = "devopsarr/prowlarr"
      version = "3.0.2"
    }
    radarr = {
      source  = "devopsarr/radarr"
      version = "2.3.3"
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

provider "sonarr" {
  url     = "https://sonarr.local.mafyuh.dev"
  api_key = data.bitwarden_secret.sonarr_api_key.value
}

provider "radarr" {
  url     = "https://radarr.local.mafyuh.dev"
  api_key = data.bitwarden_secret.radarr_api_key.value
}

provider "prowlarr" {
  url     = "https://prowlarr.local.mafyuh.dev"
  api_key = data.bitwarden_secret.prowlarr_api_key.value
}