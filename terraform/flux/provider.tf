terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.7.1"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}