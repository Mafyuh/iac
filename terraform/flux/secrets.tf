data "bitwarden_secret" "cluster_ca_certificate" {
  id = "3d1b7997-542a-4db7-9585-b2b8002f8169"
}

data "bitwarden_secret" "cluster_client_key" {
  id = "662996f3-db94-47f1-97d2-b2b8002ff234"
}

data "bitwarden_secret" "cluster_client_certificate" {
  id = "c90c5fc7-c72b-4586-a229-b2b8003045a0"
}

data "bitwarden_secret" "git_flux_password" {
  id = "e507c0be-cc1e-4d5b-90a7-b2710067c651"
}

data "bitwarden_secret" "k3s_host_tf" {
  id = "a809c809-d8b9-4bc1-8e41-b2b800358229"
}
