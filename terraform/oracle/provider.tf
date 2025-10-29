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
      version = "7.23.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.bitwarden_secret.tenancy_ocid.value
  user_ocid    = data.bitwarden_secret.user_ocid.value
  private_key  = data.bitwarden_secret.oci_private_key.value
  fingerprint  = data.bitwarden_secret.fingerprint.value
  region       = "us-ashburn-1"
}

provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}
