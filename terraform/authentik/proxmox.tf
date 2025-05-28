resource "authentik_provider_oauth2" "proxmox" {
  name      = "proxmox"
  client_id = "55f6e82f2469470515ad28260acc5d8ac1a96fd4"

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
      url           = "https://prox.${var.domains["io"]}"
    }
  ]
}

resource "authentik_application" "proxmox" {
  name              = "Proxmox"
  slug              = "prox"
  protocol_provider = authentik_provider_oauth2.proxmox.id
  meta_icon        = "/media/public/application-icons/68747470733a2f2f7777772e70726f786d6f782e636f6d2f696d616765732f70726f786d6f782f50726f786d6f785f73796d626f6c5f7374616e646172645f6865782e706e67.png"
}

resource "authentik_policy_binding" "proxmox-access" {
  target = authentik_application.proxmox.uuid
  group = authentik_group.admin_group.id
  order  = 0
}