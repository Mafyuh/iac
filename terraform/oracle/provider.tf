terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.32.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.bitwarden_secret.tenancy_ocid.value
  user_ocid = data.bitwarden_secret.user_ocid.value
  private_key = data.bitwarden_secret.oci_private_key.value
  fingerprint = data.bitwarden_secret.fingerprint.value
  region = "us-ashburn-1"
}