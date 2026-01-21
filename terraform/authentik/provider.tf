terraform {
  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "authentik.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.12.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "~> 0.1.0"
    }
  }
}

provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  project_id      = "5afc4f45-6422-4373-96cb-b2080005bf71"
}

provider "authentik" {
  url   = "https://auth.${var.domains["io"]}"
  token = data.bitwarden-secrets_secret.authentik_api_key.value
}

data "bitwarden-secrets_secret" "authentik_api_key" {
  id = "e5160d74-f16c-48aa-b554-b2be015e30a5"
}
