data "bitwarden-secrets_secret" "twingate_api_key" {
  id = "5908da32-67e8-4ef4-8bff-b2b800131d97"
}

variable "access_token" {
  description = "Access Token for BWS"
  type        = string
  sensitive   = true
}
