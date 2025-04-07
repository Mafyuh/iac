provider "flux" {
  kubernetes = {
    host = data.bitwarden_secret.k3s_host_tf.value
    client_certificate     = data.bitwarden_secret.cluster_client_certificate.value
    client_key             = data.bitwarden_secret.cluster_client_key.value
    cluster_ca_certificate = data.bitwarden_secret.cluster_ca_certificate.value
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