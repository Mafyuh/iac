resource "authentik_provider_oauth2" "netbox" {
  name      = "Netbox"
  client_id = "4rvpqbbAwCHAqQY2bNoNbbBsw1yre3ZyF2eCCfFx"

  authentication_flow  = null
  invalidation_flow    = data.authentik_flow.default-invalidation-flow.id
  authorization_flow   = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key          = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
    authentik_property_mapping_provider_scope.netbox.id,
  ]

  jwt_federation_sources = [
    authentik_source_oauth.github.uuid,
    authentik_source_oauth.proton.uuid,
    authentik_source_oauth.azure.uuid,
    authentik_source_oauth.google.uuid,
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://netbox.${var.domains["dev"]}/oauth/complete/oidc/"
    }
  ]
}

resource "authentik_application" "netbox" {
  name              = "Netbox"
  slug              = "netbox"
  protocol_provider = authentik_provider_oauth2.netbox.id
  meta_icon        = "/media/public/application-icons/netbox.png"
}