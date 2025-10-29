resource "authentik_provider_oauth2" "proxmox" {
  name      = "proxmox"
  client_id = "55f6e82f2469470515ad28260acc5d8ac1a96fd4"

  authentication_flow   = null
  invalidation_flow     = data.authentik_flow.default-invalidation-flow.id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key           = data.authentik_certificate_key_pair.main.id

  property_mappings = [
    authentik_property_mapping_provider_scope.openid.id,
    authentik_property_mapping_provider_scope.email.id,
    authentik_property_mapping_provider_scope.profile.id,
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://prox.${var.domains["io"]}"
    }
  ]
}

resource "authentik_application" "proxmox" {
  name              = "Proxmox"
  slug              = "prox"
  protocol_provider = authentik_provider_oauth2.proxmox.id
  meta_icon         = "https://github.com/Mafyuh/homelab-svg-assets/raw/refs/heads/main/assets/proxmox.svg"
}

resource "authentik_policy_binding" "proxmox-access" {
  target = authentik_application.proxmox.uuid
  group  = authentik_group.admin_group.id
  order  = 0
}
