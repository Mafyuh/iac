resource "sonarr_delay_profile" "default" {
  enable_usenet             = true
  enable_torrent            = true
  bypass_if_highest_quality = true
  usenet_delay              = 0
  torrent_delay             = 5
  tags                      = [1]
  preferred_protocol        = "usenet"
}

# resource "sonarr_download_client_sabnzbd" "sabnzbd" {
#   enable   = true
#   priority = 1
#   name     = "sabnzbd"
#   host     = "sabnzbd.arr.svc.cluster.local"
#   url_base = "/"
#   port     = 8080
#   api_key  = data.bitwarden-secrets_secret.sabnzbd_api_key.value
# }

# resource "sonarr_download_client_qbittorrent" "qbitty" {
#   enable         = true
#   priority       = 1
#   name           = "qbittorrent"
#   host           = "qbitty.arr.svc.cluster.local"
#   url_base       = "/"
#   tv_category    = "tv-sonarr"
#   port           = 8080
#   first_and_last = false
#   username       = "mafyuh"
#   password       = data.bitwarden-secrets_secret.qbitty_password.value
# }

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

resource "sonarr_root_folder" "tv" {
  path = "/data/Media/TV"
}