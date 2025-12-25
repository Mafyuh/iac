resource "authentik_provider_oauth2" "pdf" {
  name                         = "Stirling PDF"
  client_id = "3dc91fcac00cfc2e0e63aaeee0819e30abd41958"

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
      url           = "https://pdf.${var.domains["dev"]}/login/oauth2/code/authentik"
    }
  ]
}

resource "authentik_application" "pdf" {
  name              = "Stirling PDF"
  slug              = "stirling-pdf"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/stirlingpdf.svg"
  protocol_provider = authentik_provider_oauth2.pdf.id
  meta_launch_url       = "https://pdf.mafyuh.dev"
}

resource "authentik_policy_binding" "pdf-access" {
  target = authentik_application.pdf.uuid
  group  = authentik_group.jellyfin-ldap.id
  order  = 0
}
