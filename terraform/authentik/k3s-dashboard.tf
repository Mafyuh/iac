resource "authentik_provider_proxy" "k3s-dashboard" {
  name               = "k3s-dashboard"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://k3s.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "k3s-dashboard" {
  name              = "k3s-dashboard"
  slug              = "k3s-dashboard"
  meta_icon         = ""
  meta_launch_url   = "https://k3s.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.k3s-dashboard.id
}

resource "authentik_policy_binding" "k3s-dashboard-access" {
  target = authentik_application.k3s-dashboard.uuid
  group = authentik_group.admin_group.id
  order  = 0
}