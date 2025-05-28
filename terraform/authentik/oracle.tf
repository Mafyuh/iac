resource "authentik_provider_oauth2" "oracle" {
  name      = "oracle"
  client_id = "64f70c57f6503a12b1a7d9361069291137ed9dc9"

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

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://idcs-238d6750669d414dbf8796abb1799eef.identity.oraclecloud.com/oauth2/v1/social/callback"
    }
  ]
}