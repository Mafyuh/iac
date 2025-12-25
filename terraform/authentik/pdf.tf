resource "authentik_provider_proxy" "pdf" {
  name                         = "Stirling PDF"
  access_token_validity        = "hours=24"
  authorization_flow           = data.authentik_flow.default-authorization-flow.id
  external_host                = "https://pdf.${var.domains["dev"]}"
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

resource "authentik_application" "pdf" {
  name              = "Stirling PDF"
  slug              = "stirling-pdf"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/stirlingpdf.svg"
  protocol_provider = authentik_provider_proxy.pdf.id
  meta_launch_url       = "https://pdf.mafyuh.dev"
}

resource "authentik_policy_binding" "pdf-access" {
  target = authentik_application.pdf.uuid
  group  = authentik_group.jellyfin-ldap.id
  order  = 0
}
