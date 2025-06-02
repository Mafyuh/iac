resource "authentik_flow" "main-login" {
  name        = "Hello Human!"
  title       = "Hello Human!"
  slug        = "default-authentication-flow"
  designation = "authentication"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "totp-setup" {
  name        = "default-authenticator-static-setup"
  title       = "Setup Static OTP Tokens"
  slug        = "default-authenticator-static-setup"
  authentication = "require_authenticated"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "mfa-setup" {
  name        = "default-authenticator-totp-setup"
  title       = "Set up Two-Factor authentication"
  slug        = "default-authenticator-totp-setup"
  authentication = "require_authenticated"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "webauth-setup" {
  name        = "default-authenticator-webauthn-setup"
  title       = "Setup WebAuthn"
  slug        = "default-authenticator-webauthn-setup"
  authentication = "require_authenticated"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "invalidation" {
  name        = "Logout"
  title       = "Default Invalidation Flow"
  slug        = "default-invalidation-flow"
  authentication = "none"
  designation = "invalidation"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "password-change" {
  name        = "Change Password"
  title       = "Change password"
  slug        = "default-password-change"
  authentication = "require_authenticated"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "auth-app-explicit" {
  name        = "Authorize Application"
  title       = "Redirecting to %(app)s"
  slug        = "default-provider-authorization-explicit-consent"
  authentication = "require_authenticated"
  designation = "authorization"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "auth-app-implicit" {
  name        = "Authorize Application"
  title       = "Redirecting to %(app)s"
  slug        = "default-provider-authorization-implicit-consent"
  authentication = "require_authenticated"
  designation = "authorization"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "logged-out" {
  name        = "Logged out of application"
  title       = "You've logged out of %(app)s."
  slug        = "default-provider-invalidation-flow"
  authentication = "none"
  designation = "invalidation"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "user-settings" {
  name        = "User settings"
  title       = "Update your info"
  slug        = "default-user-settings-flow"
  authentication = "require_authenticated"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "duo-push" {
  name        = "Duo Push 2FA"
  title       = "Duo Push 2FA"
  slug        = "duo-push-2fa"
  authentication = "none"
  designation = "stage_configuration"
  compatibility_mode = false
  layout = "stacked"
}
##
## # Enrollment Flow - hidden from main page, only can join via invitation
resource "authentik_flow" "enrollment" {
  name        = "main-page-enrollment"
  title       = "Enrollment"
  slug        = "enrollment"
  authentication = "none"
  designation = "enrollment"
  compatibility_mode = true
  layout = "sidebar_left"
}

resource "authentik_flow_stage_binding" "enrollment0" {
  target = authentik_flow.enrollment.uuid
  stage  = authentik_stage_prompt.source.id
  order  = 10
}
resource "authentik_flow_stage_binding" "enrollment1" {
  target = authentik_flow.enrollment.uuid
  stage  = authentik_stage_user_write.source-enrollment.id
  order  = 20
}

resource "authentik_flow_stage_binding" "enrollment2" {
  target = authentik_flow.enrollment.uuid
  stage  = authentik_stage_email.source-enrollment.id
  order  = 30
}

## # Enrollment Invitation Flow
resource "authentik_flow" "enrollment-invintation" {
  name        = "Enrollment Invitation"
  title       = "Please fill in all required forms."
  slug        = "enrollment-invitation"
  authentication = "none"
  designation = "enrollment"
  compatibility_mode = true
  layout = "stacked"
}

resource "authentik_flow" "ldap-authentication" {
  name        = "ldap-authentication-flow"
  title       = "ldap-authentication-flow"
  slug        = "ldap-authentication-flow"
  authentication = "none"
  designation = "authentication"
  compatibility_mode = true
  layout = "stacked"
}

resource "authentik_flow" "passwordless" {
  name        = "Mafyuh Passwordless Flow"
  title       = "Mafyuh Passwordless Flow"
  slug        = "mafyuh-passwordless-flow"
  authentication = "none"
  designation = "authentication"
  compatibility_mode = false
  layout = "stacked"
}

resource "authentik_flow" "recovery" {
  name        = "Recovery"
  title       = "Recovery"
  slug        = "recovery"
  authentication = "none"
  designation = "recovery"
  compatibility_mode = false
  layout = "sidebar_left"
}

# resource "authentik_flow_stage_binding" "recovery0" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_dummy.name.id
#   order  = 0
# }