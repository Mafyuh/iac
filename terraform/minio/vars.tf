variable "access_token" {
  description = "Bitwarden access token"
  type        = string
  sensitive   = true
}

data "bitwarden_secret" "minio_password" {
  id = "aeb09725-39f5-47bf-823a-b31001738d02"
}