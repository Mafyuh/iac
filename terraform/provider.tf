terraform {
  required_version = ">= 1.0.0"
  required_providers {
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "3.4.0"
    }
    prowlarr = {
      source  = "devopsarr/prowlarr"
      version = "3.0.2"
    }
    radarr = {
      source  = "devopsarr/radarr"
      version = "2.3.3"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.82.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.6.4"
    }
    oci = {
      source  = "oracle/oci"
      version = "7.16.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.8.4"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
    twingate = {
      source  = "Twingate/twingate"
      version = "3.4.0"
    }
    authentik = {
      source = "goauthentik/authentik"
      version = "2025.6.0"
    }
    unifi = {
      source = "ubiquiti-community/unifi"
      version = "0.41.3"
    }
  }
}

provider "cloudflare" {
  # api_token = data.bitwarden_secret.cloudflare_api_token.value
  api_key   = data.bitwarden_secret.cloudflare_api_key.value 
  email     = "matt@mafyuh.dev"
}

provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}


provider "proxmox" {
  endpoint = "https://prox.mafyuh.xyz/"
  password = data.bitwarden_secret.ssh_password.value
  ## TODO: stop using root
  username = "root@pam"
  insecure = false
  random_vm_ids = true
  ssh {
    agent = true
  ## TODO: stop using root
    username = "root"
    password = data.bitwarden_secret.ssh_password.value

    node {
      name    = "prox"
      address = data.bitwarden_secret.prox_ip_address.value
    }

    node {
      name    = "pve2"
      address = data.bitwarden_secret.pve2_ip_address.value
    }
  }
}

provider "twingate" {
  api_token = data.bitwarden_secret.twingate_api_key.value
  network   = "mafyuh"
}

# provider "github" {
#   token = data.bitwarden_secret.github_token.value
# }