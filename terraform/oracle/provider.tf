terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.31.0"
    }
    bitwarden-secrets = {
      source  = "sebastiaan-dev/bitwarden-secrets"
      version = "0.1.2"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.bitwarden-secrets_secret.tenancy_ocid.value
  user_ocid = data.bitwarden-secrets_secret.user_ocid.value
  private_key = data.bitwarden-secrets_secret.oci_private_key.value
  fingerprint = data.bitwarden-secrets_secret.fingerprint.value
  region = "us-ashburn-1"
}