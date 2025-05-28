resource "authentik_provider_saml" "kasm" {
  name               = "kasms"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  audience          = "https://kasm.${var.domains["io"]}/api/metadata/?id=d9993337d9a148c0bfbff6c2a4ca40e8"
  acs_url           = "https://kasm.${var.domains["io"]}/api/acs/?id=d9993337d9a148c0bfbff6c2a4ca40e8"
  signing_kp        = data.authentik_certificate_key_pair.main.id
  sp_binding       = "post"
  property_mappings = [
    authentik_property_mapping_provider_saml.upn.id,
    authentik_property_mapping_provider_saml.name.id,
    authentik_property_mapping_provider_saml.email.id,
    authentik_property_mapping_provider_saml.username.id,
    authentik_property_mapping_provider_saml.uid.id,
    authentik_property_mapping_provider_saml.groups.id,
    authentik_property_mapping_provider_saml.windowsacct.id,
  ]
}

resource "authentik_application" "kasm" {
  name              = "Kasm"
  slug              = "kasm"
  meta_icon         = "/media/public/application-icons/kasm.png"
  meta_launch_url   = "https://kasm.${var.domains["io"]}"
  protocol_provider = authentik_provider_saml.kasm.id
}

resource "authentik_policy_binding" "kasm-access" {
  target = authentik_application.kasm.uuid
  group = authentik_group.admin_group.id
  order  = 0
}

resource "authentik_policy_binding" "kasm-group-access" {
  target = authentik_application.kasm.uuid
  group = authentik_group.jellyfin-ldap.id
  order  = 0
}
