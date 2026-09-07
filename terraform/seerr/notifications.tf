resource "seerr_notification_email" "main" {
  enabled      = true
  embed_poster = true

  email = {
    email_from        = "noreply@mafyuh.dev"
    sender_name       = "Seerr"
    smtp_host         = "smtp.protonmail.ch"
    smtp_port         = 587
    secure            = false
    ignore_tls        = false
    require_tls       = false
    allow_self_signed = false
    auth_user         = "noreply@mafyuh.dev"
    auth_pass         = data.bitwarden-secrets_secret.email_password.value
  }
}

resource "seerr_notification_pushover" "main" {
  enabled      = true
  embed_poster = true

  notification_types = [
    "MEDIA_PENDING",
    "MEDIA_FAILED",
    "ISSUE_CREATED",
  ]

  pushover = {
    access_token = data.bitwarden-secrets_secret.pushover_access_token.value
    user_token   = data.bitwarden-secrets_secret.pushover_user_token.value
  }
}

resource "seerr_notification_webhook" "main" {
  enabled      = true
  embed_poster = true

  notification_types = [
    "ISSUE_CREATED",
    "ISSUE_REOPENED",
  ]

  webhook = {
    webhook_url  = data.bitwarden-secrets_secret.webhook_url.value
    json_payload = file("${path.module}/webhook_payload.json")
  }
}

resource "seerr_notification_webpush" "main" {
  enabled      = true
  embed_poster = true
  webpush      = {}
}
