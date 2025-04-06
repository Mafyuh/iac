resource "prowlarr_application_sonarr" "sonarr" {
  name                  = "sonarr"
  sync_level            = "fullSync"
  base_url              = "http://sonarr.arr.svc.cluster.local:8989"
  prowlarr_url          = "http://prowlarr.arr.svc.cluster.local:9696"
  api_key               = data.bitwarden-secrets_secret.sonarr_api_key.value
  sync_categories       = [5000, 5010, 5030, 5040, 5045, 5050, 5090]
  anime_sync_categories = [5070]
}

resource "prowlarr_application_radarr" "radarr" {
  name            = "Radarr"
  sync_level      = "fullSync"
  base_url        = "http://radarr.arr.svc.cluster.local:7878"
  prowlarr_url    = "http://prowlarr.arr.svc.cluster.local:9696"
  api_key         = data.bitwarden-secrets_secret.radarr_api_key.value
  sync_categories = [2000, 2010, 2020, 2030, 2040, 2045, 2050, 2060, 2070, 2080, 2090]
}
# TODO: Getting 404 error when running these
# resource "prowlarr_download_client_sabnzbd" "sabnzbd" {
#   enable   = true
#   priority = 1
#   name     = "Sabnzbd"
#   host     = "sabnzbd.arr.svc.cluster.local"
#   port     = 8080
#   category = "prowlarr"
#   api_key  = data.bitwarden-secrets_secret.sabnzbd_api_key.value
# }

# resource "prowlarr_download_client_qbittorrent" "qbiittorrent" {
#   enable   = true
#   priority = 2
#   name     = "qbittorrent"
#   host     = "qbitty.arr.svc.cluster.local"
#   url_base = "/"
#   port     = 8080
#   category = "prowlarr"
#   username = "mafyuh"
#   password = data.bitwarden-secrets_secret.qbitty_password.value
# }

# resource "prowlarr_indexer_proxy_flaresolverr" "flaresolverr" {
#   name     = "Flaresolverr"
#   host     = "http://flaresolverr.arr.svc.cluster.local:8191/"
#   request_timeout = 60
# }