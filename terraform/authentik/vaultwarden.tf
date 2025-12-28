resource "authentik_provider_oauth2" "vaultwarden" {
  name      = "vaultwarden"
  client_id = "e17019c548f26f15e483b74b2b0a95e8900a03bb"

  authentication_flow   = null
  invalidation_flow     = data.authentik_flow.default-invalidation-flow.id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=10"
  signing_key           = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
    authentik_property_mapping_provider_scope.offline_access.id,
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://vault.${var.domains["dev"]}/identity/connect/oidc-signin"
    }
  ]
}

resource "authentik_application" "vaultwarden" {
  name              = "Vaultwarden"
  slug              = "vaultwarden"
  protocol_provider = authentik_provider_oauth2.vaultwarden.id
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/vaultwarden.svg"
}

resource "authentik_policy_binding" "vaultwarden-access" {
  target = authentik_application.vaultwarden.uuid
  group  = authentik_group.admin_group.id
  order  = 0
}
