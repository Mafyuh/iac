resource "authentik_provider_oauth2" "cloudflare" {
  name      = "Provider for Cloudflare"
  client_id = "HaRwyfeUlBCzdypqDU7hhsYTy7Ndaa4kyypQaK9A"

  authentication_flow  = null
  invalidation_flow    = data.authentik_flow.default-invalidation-flow.id
  authorization_flow   = data.authentik_flow.default-explicit-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key          = data.authentik_certificate_key_pair.generated.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://mafyuh.cloudflareaccess.com/cdn-cgi/access/callback"
    }
  ]
}


resource "authentik_application" "cloudflare" {
  name              = "Cloudflare"
  slug              = "cloudflare"
  protocol_provider = authentik_provider_oauth2.cloudflare.id
  meta_description   = "Cloudflare Access (Logs into Open WebUI, authentik)"
  meta_icon        = "/media/public/application-icons/cloudflare.svg"
}

resource "authentik_policy_binding" "cloudflare-group-access" {
  target = authentik_application.cloudflare.uuid
  group = authentik_group.jellyfin-ldap.id
  order  = 0
}