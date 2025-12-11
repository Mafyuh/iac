resource "minio_accesskey" "main" {
  user       = "mafyuh"
  access_key = "K3Bf56zgJk4DqMQnIV2m"
  status     = "enabled"
}

resource "minio_accesskey" "postgres" {
  user   = "postgres"
  status = "enabled"
}

output "minio_accesskey_pg_access_key" {
  value     = minio_accesskey.postgres.access_key
  sensitive = false
}

output "minio_accesskey_pg_secret_key" {
  value     = minio_accesskey.postgres.secret_key
  sensitive = true
}
