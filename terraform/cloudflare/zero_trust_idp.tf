resource "cloudflare_zero_trust_access_identity_provider" "authentik_access_identity_provider" {
  account_id = data.bitwarden_secret.cf_account_id.value
  config = {
    auth_url  = "https://auth.${var.domains["io"]}/application/o/authorize/"
    certs_url = "https://auth.${var.domains["io"]}/application/o/cloudflare/jwks/"
    client_id = "HaRwyfeUlBCzdypqDU7hhsYTy7Ndaa4kyypQaK9A"
    scopes    = ["openid", "email", "profile"]
    token_url = "https://auth.${var.domains["io"]}/application/o/token/"
  }
  name = "authentik"
  type = "oidc"
  scim_config = {
    enabled          = false
    seat_deprovision = false
    user_deprovision = false
  }
}
