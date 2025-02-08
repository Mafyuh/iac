data "bitwarden-secrets_secret" "git_flux_password" {
  id = "e507c0be-cc1e-4d5b-90a7-b2710067c651"
}

provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
  git = {
    url = "https://git.mafyuh.dev/mafyuh/iac"
    http = {
        username = "mafyuh"
        password = data.bitwarden-secrets_secret.git_flux_password.value
    }
  }
}

resource "flux_bootstrap_git" "flux" {
  path               = "kubernetes/cluster/production"

  lifecycle {
    ignore_changes = all
  }
}