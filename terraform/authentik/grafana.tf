resource "authentik_provider_proxy" "grafana" {
  name               = "Grafana"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://grafana.${var.domains["dev"]}"
  invalidation_flow  = "3c575d1a-1d27-4eaf-90a4-aacbccc1382f"
  internal_host_ssl_validation = true
  mode = "forward_single"
  jwt_federation_sources = [
    authentik_source_oauth.github.uuid,
    authentik_source_oauth.proton.uuid,
    authentik_source_oauth.google.uuid,
    authentik_source_oauth.azure.uuid,
  ]
}

resource "authentik_application" "grafana" {
  name              = "Grafana"
  slug              = "grafana"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/grafana.svg"
  meta_launch_url   = "https://grafana.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.grafana.id
}

resource "authentik_policy_binding" "grafana-access" {
  target = authentik_application.grafana.uuid
  group = authentik_group.admin_group.id
  order  = 0
}