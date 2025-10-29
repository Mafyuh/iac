provider "bitwarden" {
  access_token = var.access_token
  experimental {
    embedded_client = true
  }
}

provider "minio" {
  minio_server   = "s3.mafyuh.xyz"
  minio_user     = "mafyuh"
  minio_password = data.bitwarden_secret.minio_password.value
  minio_ssl      = true
}
