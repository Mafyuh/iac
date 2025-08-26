resource "radarr_download_client_qbittorrent" "qbitty" {
  enable         = true
  priority       = 1
  name           = "qBittorrent"
  host           = "10.69.69.2"
  url_base       = "/"
  movie_category = "radarr"
  port           = 8081
  first_and_last = false
  username       = "mafyuh"
  password       = data.bitwarden_secret.qbitty_password.value
  remove_failed_downloads = true
  remove_completed_downloads = true
}

resource "radarr_download_client_sabnzbd" "sabnzbd" {
  enable         = true
  priority       = 1
  name           = "SABnzbd"
  host           = "sab.mafyuh.xyz"
  url_base       = "/"
  port           = 443
  use_ssl  = true
  movie_category = "movies"
  api_key        = data.bitwarden_secret.sabnzbd_api_key.value
  remove_failed_downloads = true
  remove_completed_downloads = true
}

resource "radarr_delay_profile" "default" {
  enable_usenet             = true
  enable_torrent            = true
  bypass_if_highest_quality = true
  usenet_delay              = 0
  torrent_delay             = 5
  tags                      = [5]
  preferred_protocol        = "usenet"
}

resource "radarr_naming" "media_naming_configs" {
  rename_movies              = true
  replace_illegal_characters = true
  colon_replacement_format = "dash"
  standard_movie_format    = "{Movie CleanTitle} {(Release Year)} [imdbid-{ImdbId}] - {Edition Tags }{[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}[{Mediainfo VideoCodec}]{-Release Group}"
  movie_folder_format      = "{Movie Title} ({Release Year})"
}

resource "radarr_media_management" "media_settings_configs" {
  auto_unmonitor_previously_downloaded_movies = false
  recycle_bin                                 = ""
  recycle_bin_cleanup_days                    = 7
  download_propers_and_repacks                = "doNotPrefer"
  create_empty_movie_folders                  = false
  delete_empty_folders                        = true
  file_date                                   = "none"
  rescan_after_refresh                        = "always"
  auto_rename_folders                         = false
  paths_default_static                        = false
  set_permissions_linux                       = false
  chmod_folder                                = 755
  chown_group                                 = ""
  skip_free_space_check_when_importing        = true
  minimum_free_space_when_importing           = 100
  copy_using_hardlinks                        = true
  import_extra_files                          = true
  extra_file_extensions                       = "srt,nfo,png"
  enable_media_info                           = true
}

resource "radarr_notification_gotify" "gotify" {
  on_grab                          = true
  on_download                      = true
  on_upgrade                       = true
  on_movie_added                   = false
  on_movie_delete                  = false
  on_movie_file_delete             = false
  on_movie_file_delete_for_upgrade = true
  on_health_issue                  = false
  on_application_update            = false
  include_health_warnings = false
  name                    = "Gotify"
  server    = "https://go.mafyuh.io"
  app_token = data.bitwarden_secret.gotify_radarr_key.value
  priority  = 8
}

resource "radarr_root_folder" "marvel" {
  path = "/data/Media/Marvel"
}

# resource "radarr_root_folder" "dc" {
#   path = "/data/Media/DC"
# }

resource "radarr_root_folder" "kids" {
  path = "/data/Media/Kids"
}

resource "radarr_root_folder" "movies" {
  path = "/data/Media/Movies"
}

# resource "radarr_root_folder" "requests" {
#   path = "/data/Media/Requests"
# }

resource "radarr_root_folder" "stand-up" {
  path = "/data/Media/Stand-Up"
}