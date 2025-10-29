resource "authentik_provider_oauth2" "pgadmin" {
  name      = "pgAdmin"
  client_id = "EaztSI9BjIQfQ5aTOA0es7aXFuks0s88u9KpAOYH"

  authentication_flow  = null
  invalidation_flow    = data.authentik_flow.default-invalidation-flow.id
  authorization_flow   = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key          = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
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
      url           = "https://pg.${var.domains["dev"]}/oauth2/authorize"
    }
  ]
}

resource "authentik_application" "pgadmin" {
  name              = "pgAdmin"
  slug              = "pgadmin"
  protocol_provider = authentik_provider_oauth2.pgadmin.id
  meta_icon        = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/postgresql.svg"
}

resource "authentik_policy_binding" "pgadmin-access" {
  target = authentik_application.pgadmin.uuid
  group = authentik_group.admin_group.id
  order  = 0
}