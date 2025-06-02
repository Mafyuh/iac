resource "authentik_stage_authenticator_duo" "duo" {
  name = "duo-push-2fa-setup"
  client_id = "DI8VP7CXGDIG44Y96LRN"
  client_secret = "null"
  api_hostname  = "api-a4b1670f.duosecurity.com"
  admin_integration_key = "DIHSZZOGK1DRTYWGBDVD"
  configure_flow = authentik_flow.duo-push.uuid
  friendly_name = "duo-push-2fa-setup"
  lifecycle {
    ignore_changes = [
      client_secret,
    ]
  }
}

resource "authentik_stage_authenticator_static" "static" {
  name = "default-authenticator-static-setup"
  configure_flow = authentik_flow.totp-setup.uuid
  friendly_name = "Static tokens"
}

## Enrollment
resource "authentik_stage_invitation" "enrollment-invintation" {
  name = "enrollment-invintation"
}

resource "authentik_stage_prompt" "source" {
  name = "default-source-enrollment-prompt"
  fields = [
    authentik_stage_prompt_field.username.id,
    authentik_stage_prompt_field.email.id,
    authentik_stage_prompt_field.init-password.id,
    authentik_stage_prompt_field.repeat-password.id,
  ]
}

resource "authentik_stage_user_write" "source-enrollment" {
  name = "default-source-enrollment-write"
  user_creation_mode = "always_create"
  user_type = "internal"
  create_users_group = "433a8b88-e75e-48a9-a049-2db4d7eee293"
}

resource "authentik_stage_email" "source-enrollment" {
  name = "email-account-confirmation"
  activate_user_on_success = true
  subject = "Account Confirmation"
  template = "email/account_confirmation.html"
  timeout = 10
}