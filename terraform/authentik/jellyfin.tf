resource "authentik_provider_ldap" "jellyfin" {
  name            = "Jellyfin"
  certificate     = data.authentik_certificate_key_pair.main.id
  base_dn         = "DC=ldap,DC=mafyuh,DC=io" ## This doesnt matter for authentik
  tls_server_name = "ldap.mafyuh.xyz"
  bind_flow       = data.authentik_flow.ldap-authentication-flow.id
  unbind_flow     = data.authentik_flow.default-invalidation-flow.id
}

resource "authentik_application" "jellyfin" {
  name              = "Jellyfin"
  slug              = "jellyfin"
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/jellyfin.svg"
  meta_description  = "My Streaming Service - To Request Stuff https://request.${var.domains["io"]}"
  meta_launch_url   = "https://jelly.${var.domains["io"]}/"
  protocol_provider = authentik_provider_ldap.jellyfin.id
}

resource "authentik_policy_binding" "jellyfin-group-access" {
  target = authentik_application.jellyfin.uuid
  group  = authentik_group.jellyfin-ldap.id
  order  = 0
}

resource "authentik_policy_expression" "jellyfin-ldap-avatar-sync" {
  name       = "jellyfin-ldap-avatar-sync"
  expression = <<EOF
try:
    flow_plan = request.context.get("flow_plan")
    user = None
    if flow_plan:
        user = flow_plan.context.get("pending_user")
    if user is None:
        user = getattr(request, "user", None)
    if user is None or not getattr(user, "is_authenticated", False):
        return True
    avatar = getattr(user, "avatar", None)
    attrs = getattr(user, "attributes", None) or {}
    if avatar:
        url = "https://auth.${var.domains["io"]}" + avatar.url
        if attrs.get("avatar-url") != url:
            attrs["avatar-url"] = url
            user.attributes = attrs
            user.save(update_fields=["attributes"])
    else:
        if "avatar-url" in attrs:
            attrs.pop("avatar-url", None)
            user.attributes = attrs
            user.save(update_fields=["attributes"])
except Exception:
    pass
return True
EOF
}

resource "authentik_policy_binding" "jellyfin-ldap-avatar-sync" {
  target = authentik_flow.ldap-authentication.uuid
  policy = authentik_policy_expression.jellyfin-ldap-avatar-sync.id
  order  = 0
}
