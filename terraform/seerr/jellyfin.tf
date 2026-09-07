resource "seerr_jellyfin_settings" "main" {
  ip                           = "10.0.0.10"
  port                         = 8096
  use_ssl                      = false
  url_base                     = ""
  external_hostname            = data.bitwarden-secrets_secret.jellyfin_external_url.value
  jellyfin_forgot_password_url = "https://auth.mafyuh.io/if/flow/recovery/?next=%2F"
  api_key                      = data.bitwarden-secrets_secret.jellyfin_api_key.value
}
