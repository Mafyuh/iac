terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.5.1"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
  }
}