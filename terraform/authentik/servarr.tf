## Prowlarr
resource "authentik_provider_proxy" "prowlarr" {
  name               = "Prowlarr"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://prowlarr.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "prowlarr" {
  name              = "Prowlarr"
  slug              = "prowlarr"
  meta_icon         = "/media/public/application-icons/prowlarr-banner_oiqdKpC.png"
  meta_launch_url   = "https://prowlarr.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.prowlarr.id
}

## Radarr
resource "authentik_provider_proxy" "radarr" {
  name               = "radarr"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://radarr.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  basic_auth_enabled = true
  basic_auth_username_attribute = "arr_user"
  basic_auth_password_attribute = "arr_password"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "radarr" {
  name              = "Radarr"
  slug              = "radarr"
  meta_icon         = "/media/public/application-icons/radarr-icon-462x512-bydv4e4f.png"
  meta_launch_url   = "https://radarr.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.radarr.id
}

## Sonarr
resource "authentik_provider_proxy" "sonarr" {
  name               = "sonarr"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://sonarr.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  basic_auth_enabled = true
  basic_auth_username_attribute = "arr_user"
  basic_auth_password_attribute = "arr_password"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "sonarr" {
  name              = "Sonarr"
  slug              = "sonarr"
  meta_icon         = "/media/public/application-icons/sonarr-icon-1024x1024-wkay604k.png"
  meta_launch_url   = "https://sonarr.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.sonarr.id
}

## Sabnzbd
resource "authentik_provider_proxy" "sabnzbd" {
  name               = "sabnzbd"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://sab.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "sabnzbd" {
  name              = "Sabnzbd"
  slug              = "sabnzbd"
  meta_icon         = "/media/public/application-icons/download2.png"
  meta_launch_url   = "https://sab.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.sabnzbd.id
}

## Lidarr
resource "authentik_provider_proxy" "lidarr" {
  name               = "lidarr"
  access_token_validity = "hours=24"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  external_host      = "https://lidarr.local.${var.domains["dev"]}"
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id
  skip_path_regex    = "^/api([/?].*)?$"
  internal_host_ssl_validation = false
  mode = "forward_single"
}

resource "authentik_application" "lidarr" {
  name              = "Lidarr"
  slug              = "lidarr"
  meta_icon         = "/media/public/application-icons/28475832.png"
  meta_launch_url   = "https://lidarr.local.${var.domains["dev"]}"
  protocol_provider = authentik_provider_proxy.lidarr.id
}

## Bazarr
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

