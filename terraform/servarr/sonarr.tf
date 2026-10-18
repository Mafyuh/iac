resource "sonarr_delay_profile" "default" {
  enable_usenet             = true
  enable_torrent            = true
  bypass_if_highest_quality = true
  usenet_delay              = 0
  torrent_delay             = 5
  tags                      = [1]
  preferred_protocol        = "usenet"
}

resource "sonarr_download_client_sabnzbd" "sabnzbd" {
  enable                     = true
  priority                   = 1
  name                       = "sabnzbd"
  host                       = "sab.iac.gg"
  use_ssl                    = true
  url_base                   = "/"
  port                       = 443
  api_key                    = data.bitwarden-secrets_secret.sabnzbd_api_key.value
  tv_category                = "tv"
  remove_failed_downloads    = true
  remove_completed_downloads = true
  older_tv_priority          = -100
  recent_tv_priority         = -100
  tags                       = []
}

resource "sonarr_download_client_qbittorrent" "qbitty" {
  enable         = true
  priority       = 1
  name           = "qbittorrent"
  host           = "qbitty.iac.gg"
  url_base       = "/"
  tv_category    = "tv-sonarr"
  port           = 443
  use_ssl        = true
  first_and_last = false
  username       = "mafyuh"
  password       = data.bitwarden-secrets_secret.qbitty_password.value
}

resource "sonarr_naming" "media_naming_configs" {
  rename_episodes            = true
  replace_illegal_characters = true
  multi_episode_style        = 5
  colon_replacement_format   = 4
  standard_episode_format    = "{Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}"
  daily_episode_format       = "{Series TitleYear} - {Air-Date} - {Episode CleanTitle} [{Custom Formats }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}"
  anime_episode_format       = "{Series Title} - S{season:00}E{episode:00} - {Episode Title} {Quality Full}"
  series_folder_format       = "{Series Title}"
  season_folder_format       = "Season {season:00}"
  specials_folder_format     = "Season 00"
}

resource "sonarr_media_management" "media_settings_configs" {
  unmonitor_previous_episodes = true
  hardlinks_copy              = true
  create_empty_folders        = false
  delete_empty_folders        = true
  enable_media_info           = true
  import_extra_files          = true
  set_permissions             = false
  skip_free_space_check       = true
  minimum_free_space          = 100
  recycle_bin_days            = 7
  chmod_folder                = "755"
  chown_group                 = ""
  download_propers_repacks    = "doNotPrefer"
  episode_title_required      = "always"
  extra_file_extensions       = "srt,nfo,png"
  file_date                   = "none"
  recycle_bin_path            = ""
  rescan_after_refresh        = "always"
}

resource "sonarr_notification_pushover" "pushover" {
  on_grab                            = false
  on_download                        = false
  on_upgrade                         = true
  on_import_complete                 = true
  on_series_add                      = false
  on_series_delete                   = false
  on_episode_file_delete             = false
  on_episode_file_delete_for_upgrade = true
  on_health_issue                    = false
  on_health_restored                 = false
  on_manual_interaction_required     = true
  on_application_update              = false
  include_health_warnings            = false
  name                               = "Pushover"
  api_key                            = data.bitwarden-secrets_secret.sonarr_pushover_api_key.value
  user_key                           = data.bitwarden-secrets_secret.pushover_user_key.value
  priority                           = 0
  tags                               = []
}

resource "sonarr_root_folder" "tv" {
  path = "/data/Media/TV"
}
