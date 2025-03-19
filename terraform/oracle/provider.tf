terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.30.0"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
  }
}