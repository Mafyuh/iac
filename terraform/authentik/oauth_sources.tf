resource "authentik_source_oauth" "discord" {
  name                = "Discord"
  slug                = "discord"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null

  provider_type      = "discord"
  consumer_key       = "1132849371034161203"
  consumer_secret    = ""
  user_matching_mode = "email_link"
  ## Oauth Sources need consumer key, instead of adding more Bitwarden secrets I am just ignoring
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}

resource "authentik_source_oauth" "azure" {
  name                = "Azure Ad"
  slug                = "azure-ad"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null
  access_token_url    = "https://login.microsoftonline.com/common/oauth2/token"
  authorization_url   = "https://login.microsoftonline.com/common/oauth2/authorize"
  oidc_jwks_url       = "https://login.microsoftonline.com/common/discovery/keys"
  oidc_well_known_url = "https://login.microsoftonline.com/common/.well-known/openid-configuration"
  profile_url         = "https://login.microsoftonline.com/common/openid/userinfo"
  provider_type       = "azuread"
  consumer_key        = "2bb37b8d-20b6-4bc4-b0d7-1c430bd3dc17"
  consumer_secret     = ""
  user_matching_mode  = "identifier"
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}

resource "authentik_source_oauth" "github" {
  name                = "Github"
  slug                = "github"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null
  oidc_jwks_url       = "https://token.actions.githubusercontent.com/.well-known/jwks"
  provider_type       = "github"
  consumer_key        = "23e44028c4127490260f"
  consumer_secret     = ""
  user_matching_mode  = "email_link"
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}

resource "authentik_source_oauth" "google" {
  name                = "Google"
  slug                = "google"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null
  provider_type       = "google"
  consumer_key        = "1077490329116-tr1rqejs3222hegj3sakfo8eoe602qlf.apps.googleusercontent.com"
  consumer_secret     = ""
  access_token_url    = "https://oauth2.googleapis.com/token"
  authorization_url   = "https://accounts.google.com/o/oauth2/v2/auth"
  oidc_jwks_url       = "https://www.googleapis.com/oauth2/v3/certs"
  profile_url         = "https://openidconnect.googleapis.com/v1/userinfo"
  user_matching_mode  = "email_link"
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}

resource "authentik_source_oauth" "reddit" {
  name                = "Reddit"
  slug                = "reddit"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null
  provider_type       = "reddit"
  consumer_key        = "cgvr02ym6FvOPnIles8FJw"
  consumer_secret     = ""
  user_matching_mode  = "username_link"
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}

resource "authentik_source_oauth" "proton" {
  name                = "SimpleLogin"
  slug                = "simplelogin"
  authentication_flow = data.authentik_flow.default-source-authentication.id
  enrollment_flow     = null
  provider_type       = "openidconnect"
  consumer_key        = "authentik-nwzinlvgqx"
  consumer_secret     = ""
  user_matching_mode  = "email_link"
  access_token_url    = "https://app.simplelogin.io/oauth2/token"
  authorization_url   = "https://app.simplelogin.io/oauth2/authorize"
  oidc_jwks_url       = "https://app.simplelogin.io/jwks"
  oidc_well_known_url = "https://app.simplelogin.io/.well-known/openid-configuration"
  profile_url         = "https://app.simplelogin.io/oauth2/userinfo"
  lifecycle {
    ignore_changes = [
      consumer_secret,
    ]
  }
}
