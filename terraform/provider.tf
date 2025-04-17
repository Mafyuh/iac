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
      version = "2.3.2"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.5.1"
    }
    oci = {
      source  = "oracle/oci"
      version = "6.34.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.3.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.13.5"
    }
    twingate = {
      source  = "Twingate/twingate"
      version = "3.0.18"
    }
    authentik = {
      source = "goauthentik/authentik"
      version = "2025.2.0"
    }
    # pfsense = {
    #   source  = "marshallford/pfsense"
    #   version = "0.15.0"
    # }
  }
}

provider "cloudflare" {
  api_token = data.bitwarden_secret.cloudflare_api_token.value
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