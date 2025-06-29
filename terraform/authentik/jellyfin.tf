resource "authentik_provider_ldap" "jellyfin" {
  name               = "Jellyfin"
  certificate        = data.authentik_certificate_key_pair.main.id
  base_dn            = "DC=ldap,DC=mafyuh,DC=io" ## This doesnt matter for authentik
  tls_server_name     = "ldap.mafyuh.xyz"
  bind_flow          = data.authentik_flow.ldap-authentication-flow.id
  unbind_flow        = data.authentik_flow.default-invalidation-flow.id
}

resource "authentik_application" "jellyfin" {
  name              = "Jellyfin"
  slug              = "jellyfin"
  meta_icon         = "/media/public/application-icons/icon-transparent.png"
  meta_description   = "My Streaming Service - To Request Stuff https://request.${var.domains["io"]}"
  meta_launch_url   = "https://jelly.${var.domains["io"]}/"
  protocol_provider = authentik_provider_ldap.jellyfin.id
}

resource "authentik_policy_binding" "jellyfin-group-access" {
  target = authentik_application.jellyfin.uuid
  group = authentik_group.jellyfin-ldap.id
  order  = 0
}