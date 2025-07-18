terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.7.1"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.14.0"
    }
  }
}  