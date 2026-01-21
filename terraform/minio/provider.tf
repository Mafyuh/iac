provider "bitwarden-secrets" {
  access_token    = var.access_token
  organization_id = "305f1e91-cd2b-411c-8acf-b1a3004a82b2"
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
}

provider "minio" {
  minio_server   = "s3.mafyuh.xyz"
  minio_user     = "mafyuh"
  minio_password = data.bitwarden-secrets_secret.minio_password.value
  minio_ssl      = true
}
