resource "authentik_provider_proxy" "pdf" {
  name                         = "Bento PDF"
  access_token_validity        = "hours=24"
  authorization_flow           = data.authentik_flow.default-authorization-flow.id
  external_host                = "https://pdf.iac.gg"
  invalidation_flow            = "3c575d1a-1d27-4eaf-90a4-aacbccc1382f"
  internal_host_ssl_validation = true
  mode                         = "forward_single"
  jwt_federation_sources = [
    authentik_source_oauth.github.uuid,
    authentik_source_oauth.proton.uuid,
    authentik_source_oauth.google.uuid,
    authentik_source_oauth.azure.uuid,
  ]
}

resource "authentik_policy_binding" "pdf-access" {
  target = "7103aad0-f680-49d3-80a2-60950ec93a34"
  group  = authentik_group.jellyfin-ldap.id
  order  = 0
}
