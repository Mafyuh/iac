resource "authentik_provider_ldap" "jellyfin" {
  name               = "Jellyfin"
  base_dn            = "DC=ldap,DC=mafyuh,DC=io"
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