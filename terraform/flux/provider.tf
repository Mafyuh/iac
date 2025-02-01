terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.4.0"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
  }
}