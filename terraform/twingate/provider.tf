terraform {
  required_providers {
    twingate = {
      source  = "Twingate/twingate"
      version = "3.4.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.14.0"
    }
  }
}

provider "twingate" {
  api_token = data.bitwarden_secret.twingate_api_key.value
  network   = "mafyuh"
}