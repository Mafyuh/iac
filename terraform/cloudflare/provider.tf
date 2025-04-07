terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.2.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
  }
}  