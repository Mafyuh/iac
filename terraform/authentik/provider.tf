terraform {
  backend "s3" {
    bucket                        = "tofu"
    region                        = "us-east-1"
    key                           = "authentik.tfstate"
    endpoint                      = "https://s3.mafyuh.xyz"
    skip_region_validation        = true
    skip_credentials_validation   = true
    skip_requesting_account_id    = true
    use_path_style                = true
    skip_s3_checksum              = true
    skip_metadata_api_check       = true
  }

  required_providers {
    authentik = {
      source = "goauthentik/authentik"
      version = "2025.10.0"
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

provider "authentik" {
  url   = "https://auth.${var.domains["io"]}"
  token = data.bitwarden_secret.authentik_api_key.value
}

data "bitwarden_secret" "authentik_api_key" {
  id = "e5160d74-f16c-48aa-b554-b2be015e30a5"
}

