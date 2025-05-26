terraform {
  required_providers {
    unifi = {
      source = "ubiquiti-community/unifi"
      version = "0.41.2"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.6"
    }
  }
}

provider "unifi" {
  username = "terraform"
  password = data.bitwarden_secret.unifi_password.value
  api_url  = "https://10.0.0.1"
  allow_insecure = "true"
}