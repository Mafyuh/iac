terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket                      = "tofu"
    region                      = "us-east-1"
    key                         = "unifi.tfstate"
    endpoint                    = "https://s3.mafyuh.xyz"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
  }

  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.5"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}

provider "unifi" {
  username       = "terraform"
  password       = data.bitwarden_secret.unifi_password.value
  api_url        = "https://10.0.0.1"
  allow_insecure = "true"
}

provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}
