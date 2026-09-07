resource "seerr_radarr_server" "main" {
  name                   = "Radarr"
  hostname               = "radarr-app.arr.svc.cluster.local"
  port                   = 7878
  use_ssl                = false
  base_url               = ""
  api_key                = data.bitwarden-secrets_secret.radarr_api_key.value
  quality_profile_id     = 9
  quality_profile_name   = "HD Bluray + WEB"
  active_directory       = "/data/Media/Requests"
  minimum_availability   = "released"
  is_4k                  = false
  is_default             = true
  sync_enabled           = false
  prevent_search         = false
  tag_requests_with_user = true
  tags                   = []
}

resource "seerr_sonarr_server" "main" {
  name                   = "Sonarr"
  hostname               = "sonarr-app.arr.svc.cluster.local"
  port                   = 8989
  use_ssl                = false
  base_url               = ""
  api_key                = data.bitwarden-secrets_secret.sonarr_api_key.value
  quality_profile_id     = 7
  quality_profile_name   = "WEB-1080p"
  active_directory       = "/data/Media/TV"
  active_anime_directory = "/data/Media/TV"
  enable_season_folders  = false
  is_4k                  = false
  is_default             = true
  sync_enabled           = false
  prevent_search         = false
  tag_requests_with_user = true
  tags                   = []
  anime_tags             = []
}
