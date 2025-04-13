resource "authentik_provider_proxy" "bazarr" {
  name               = "Bazarr"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://bazarr.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "bazarr" {
  name              = "Bazarr"
  slug              = "bazarr"
  meta_icon         = "/media/public/application-icons/bazarr.svg"
  meta_launch_url   = "https://bazarr.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.bazarr.id
}

