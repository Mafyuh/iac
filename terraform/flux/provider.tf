terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.5.1"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
  }
}