terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.6.3"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.14.0"
    }
  }
}