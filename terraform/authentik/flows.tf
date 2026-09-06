resource "authentik_flow" "main-login" {
  name               = "Welcome to authentik!"
  title              = "Welcome to authentik!"
  slug               = "default-authentication-flow"
  background         = ""
  designation        = "authentication"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "totp-setup" {
  name               = "default-authenticator-static-setup"
  title              = "Setup Static OTP Tokens"
  slug               = "default-authenticator-static-setup"
  background         = "flow-backgrounds/thumb-1920-606500_6jZLEd5.jpg"
  authentication     = "require_authenticated"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "mfa-setup" {
  name               = "default-authenticator-totp-setup"
  title              = "Set up Two-Factor authentication"
  slug               = "default-authenticator-totp-setup"
  background         = "flow-backgrounds/thumb-1920-606500_IDu2O5t.jpg"
  authentication     = "require_authenticated"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "webauth-setup" {
  name               = "default-authenticator-webauthn-setup"
  title              = "Setup WebAuthn"
  slug               = "default-authenticator-webauthn-setup"
  background         = "flow-backgrounds/thumb-1920-606500_zh20s51.jpg"
  authentication     = "require_authenticated"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "invalidation" {
  name               = "Logout"
  title              = "Default Invalidation Flow"
  slug               = "default-invalidation-flow"
  background         = "flow-backgrounds/thumb-1920-606500_L90mH9n.jpg"
  authentication     = "none"
  designation        = "invalidation"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "password-change" {
  name               = "Change Password"
  title              = "Change password"
  slug               = "default-password-change"
  background         = "flow-backgrounds/thumb-1920-606500_iGQPvBy.jpg"
  authentication     = "require_authenticated"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "auth-app-explicit" {
  name               = "Authorize Application"
  title              = "Redirecting to %(app)s"
  slug               = "default-provider-authorization-explicit-consent"
  background         = "flow-backgrounds/thumb-1920-606500_92ohqHJ.jpg"
  authentication     = "require_authenticated"
  designation        = "authorization"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "auth-app-implicit" {
  name               = "Authorize Application"
  title              = "Redirecting to %(app)s"
  slug               = "default-provider-authorization-implicit-consent"
  background         = "flow-backgrounds/thumb-1920-606500_ybm16Dm.jpg"
  authentication     = "require_authenticated"
  designation        = "authorization"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "logged-out" {
  name               = "Logged out of application"
  title              = "You've logged out of %(app)s."
  slug               = "default-provider-invalidation-flow"
  background         = "flow-backgrounds/thumb-1920-606500_E86JBm5.jpg"
  authentication     = "none"
  designation        = "invalidation"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "user-settings" {
  name               = "User settings"
  title              = "Update your info"
  slug               = "default-user-settings-flow"
  background         = "flow-backgrounds/thumb-1920-606500_73rS2U7.jpg"
  authentication     = "require_authenticated"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "duo-push" {
  name               = "Duo Push 2FA"
  title              = "Duo Push 2FA"
  slug               = "duo-push-2fa"
  background         = "flow-backgrounds/thumb-1920-606500_7ZGHAkq.jpg"
  authentication     = "none"
  designation        = "stage_configuration"
  compatibility_mode = false
  layout             = "stacked"
}
##
## # Enrollment Flow - hidden from main page, only can join via invitation
resource "authentik_flow" "enrollment" {
  name               = "main-page-enrollment"
  title              = "Enrollment"
  slug               = "enrollment"
  background         = "https://github.com/Mafyuh/homelab-svg-assets/blob/main/thumb-1920-606500.jpg?raw=true"
  authentication     = "none"
  designation        = "enrollment"
  compatibility_mode = true
  layout             = "stacked"
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
  name               = "Enrollment Invitation"
  title              = "Please fill in all required forms."
  slug               = "enrollment-invitation"
  background         = "flow-backgrounds/thumb-1920-606500_tJa0sjB.jpg"
  authentication     = "none"
  designation        = "enrollment"
  compatibility_mode = true
  layout             = "stacked"
}

resource "authentik_flow" "ldap-authentication" {
  name               = "ldap-authentication-flow"
  title              = "ldap-authentication-flow"
  slug               = "ldap-authentication-flow"
  background         = "flow-backgrounds/thumb-1920-606500_ZLqlLyi.jpg"
  authentication     = "none"
  designation        = "authentication"
  compatibility_mode = true
  layout             = "stacked"
}

resource "authentik_flow" "passwordless" {
  name               = "Mafyuh Passwordless Flow"
  title              = "Mafyuh Passwordless Flow"
  slug               = "mafyuh-passwordless-flow"
  background         = "flow-backgrounds/thumb-1920-606500_4JgqZYr.jpg"
  authentication     = "none"
  designation        = "authentication"
  compatibility_mode = false
  layout             = "stacked"
}

resource "authentik_flow" "recovery" {
  name               = "Recovery"
  title              = "Recovery"
  slug               = "recovery"
  background         = "https://github.com/Mafyuh/homelab-svg-assets/blob/main/thumb-1920-606500.jpg?raw=true"
  authentication     = "none"
  designation        = "recovery"
  compatibility_mode = false
  layout             = "stacked"
}

# resource "authentik_flow_stage_binding" "recovery0" {
#   target = authentik_flow.recovery.uuid
#   stage  = authentik_stage_dummy.name.id
#   order  = 0
# }
