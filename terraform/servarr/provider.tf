terraform {
  required_version = ">= 1.0.0"
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
      version = "2.3.2"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
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