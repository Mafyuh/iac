terraform {
  required_providers {
authentik = {
      source = "goauthentik/authentik"
      version = "2025.6.0"
    }
bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.6"
    }
  }
}

provider "authentik" {
  url   = "https://auth.${var.domains["io"]}"
  token = data.bitwarden_secret.authentik_api_key.value
}

data "bitwarden_secret" "authentik_api_key" {
  id = "e5160d74-f16c-48aa-b554-b2be015e30a5"
}