resource "authentik_provider_oauth2" "grafana" {
  name      = "grafana"
  client_id = "5be249b401c30c2c6288f540d5ae4c271f653694"

  authentication_flow   = null
  invalidation_flow     = data.authentik_flow.default-invalidation-flow.id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=10"
  signing_key           = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
  ]

  allowed_redirect_uris = [
    {
      matching_mode     = "strict"
      redirect_uri_type = "authorization"
      url               = "https://grafana.iac.gg/login/generic_oauth"
    }
  ]
}

resource "authentik_application" "grafana" {
  name              = "Grafana"
  slug              = "grafana"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/grafana.svg"
  meta_launch_url   = "https://grafana.iac.gg"
  protocol_provider = authentik_provider_oauth2.grafana.id
}

resource "authentik_policy_binding" "grafana-access" {
  target = authentik_application.grafana.uuid
  group  = authentik_group.admin_group.id
  order  = 0
}
