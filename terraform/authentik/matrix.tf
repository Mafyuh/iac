resource "authentik_provider_oauth2" "matrix" {
  name                         = "Matrix"
  client_id = "BvM5CUdFjcZZ1OFJjDxy0mCrQqkezey1agpCk09X"

  authentication_flow   = null
  invalidation_flow     = data.authentik_flow.default-invalidation-flow.id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key           = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://auth.${var.domains["dev"]}/upstream/callback/01HFVBY12TMNTYTBV8W921M5FB"
    }
  ]
}

resource "authentik_application" "matrix" {
  name              = "Matrix"
  slug              = "matrix"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/matrix-black.svg"
  protocol_provider = authentik_provider_oauth2.matrix.id
}

resource "authentik_policy_binding" "matrix-access" {
  target = authentik_application.matrix.uuid
  group  = authentik_group.jellyfin-ldap.id
  order  = 0
}
