## Default LDAP Provider and App
resource "authentik_provider_ldap" "ldap" {
  name        = "LDAP"
  base_dn     = "DC=ldap,DC=goauthentik,DC=io"
  bind_flow   = data.authentik_flow.ldap-authentication-flow.id
  unbind_flow = data.authentik_flow.default-invalidation-flow.id
  mfa_support = false
}

resource "authentik_application" "ldap" {
  name              = "LDAP"
  slug              = "ldap"
  meta_icon         = null
  protocol_provider = authentik_provider_ldap.ldap.id
}
