resource "authentik_provider_proxy" "grafana" {
  name               = "Grafana"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://grafana.${var.domains["dev"]}"
  invalidation_flow  = "3c575d1a-1d27-4eaf-90a4-aacbccc1382f"
  internal_host_ssl_validation = true
  mode = "forward_single"
  ## Get added as data sources
  jwt_federation_sources = [
    "e3ac1e00-3c72-4799-bc3f-301d408c7dc1",
    "d782a21d-20fd-4392-8f7a-dff987d71718",
    "3a27892c-bc37-47c4-b53d-42ca78ed9775",
    "ea7a4c9e-f641-4ac3-8d2a-5d6a44cc2ef4",
  ]
}

resource "authentik_application" "grafana" {
  name              = "Grafana"
  slug              = "grafana"
  meta_icon         = "/media/public/application-icons/Grafana_icon.svg_5sO5qLM.png"
  meta_launch_url   = "https://grafana.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.grafana.id
}