resource "authentik_provider_oauth2" "linkwarden" {
  name      = "Provider for Linkwarden"
  client_id = "UqV1m52fhye35Cng5wkirPBYCXyUKGWAgaKSkn5M"

  authentication_flow  = null
  invalidation_flow    = data.authentik_flow.default-invalidation-flow.id
  authorization_flow   = data.authentik_flow.default-authorization-flow.id
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
      url           = "https://links.${var.domains["dev"]}/api/v1/auth/callback/authentik"
    }
  ]
}

resource "authentik_application" "linkwarden" {
  name              = "Linkwarden"
  slug              = "linkwarden"
  protocol_provider = authentik_provider_oauth2.linkwarden.id
  meta_icon        = "/media/public/application-icons/linkwarden.png"
  meta_launch_url   = "https://links.${var.domains["dev"]}"
}

resource "authentik_policy_binding" "linkwarden-access" {
  target = authentik_application.linkwarden.uuid
  group = authentik_group.admin_group.id
  order  = 0
}