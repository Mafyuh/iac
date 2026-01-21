terraform {
  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "oci.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.30.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.bitwarden-secrets_secret.tenancy_ocid.value
  user_ocid    = data.bitwarden-secrets_secret.user_ocid.value
  private_key  = data.bitwarden-secrets_secret.oci_private_key.value
  fingerprint  = data.bitwarden-secrets_secret.fingerprint.value
  region       = "us-ashburn-1"
}

provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
}
