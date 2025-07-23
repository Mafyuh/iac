resource "authentik_provider_proxy" "k3s-dashboard" {
  name               = "Headlamp Proxy"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://k3s.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  internal_host_ssl_validation = false
  mode = "forward_single"
  skip_path_regex    = "/oidc-callback"
}

resource "authentik_application" "k3s-dashboard" {
  name              = "Headlamp Proxy"
  slug              = "headlamp-proxy"
  meta_icon         = "/media/public/application-icons/headlamp_ZBhHPe9.jpeg"
  meta_launch_url   = "https://k3s.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.k3s-dashboard.id
}

resource "authentik_policy_binding" "k3s-dashboard-access" {
  target = authentik_application.k3s-dashboard.uuid
  group = authentik_group.admin_group.id
  order  = 0
}

## OIDC
resource "authentik_provider_oauth2" "headlamp" {
  name      = "headlamp"
  client_id = "F0xxCXseO1lSK9iygiJaiFuI0JTuvhQnzRFVwFAa"

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
      url           = "https://k3s.${var.domains["dev"]}/oidc-callback"
    }
  ]
}

# resource "authentik_application" "headlamp-oidc" {
#   name              = "Headlamp"
#   slug              = "headlamp"
#   meta_icon         = "/media/public/application-icons/headlamp_ZBhHPe9.jpeg"
#   meta_launch_url   = "https://k3s.${var.domains["dev"]}"
#   protocol_provider = authentik_provider_oauth2.headlamp.id
# }