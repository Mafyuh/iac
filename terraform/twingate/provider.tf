terraform {
  required_providers {
    twingate = {
      source  = "Twingate/twingate"
      version = "3.3.2"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.6"
    }
  }
}

provider "twingate" {
  api_token = data.bitwarden_secret.twingate_api_key.value
  network   = "mafyuh"
}