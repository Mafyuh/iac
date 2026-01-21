terraform {
  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "minio.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "3.13.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}
