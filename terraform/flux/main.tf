data "bitwarden_secret" "git_flux_password" {
  id = "e507c0be-cc1e-4d5b-90a7-b2710067c651"
}

provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
  git = {
    url = "https://github.com/mafyuh/iac"
    http = {
        username = "Mafyuh"
        password = data.bitwarden_secret.git_flux_password.value
    }
  }
}

resource "flux_bootstrap_git" "flux" {
  path               = "kubernetes/cluster/production"
  version            = "v2.5.0"
}