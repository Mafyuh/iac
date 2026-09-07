resource "seerr_main_settings" "main" {
  app_title          = "Seerr"
  application_url    = ""
  cache_images       = false
  hide_available     = false
  local_login        = false
  media_server_login = true
  new_plex_login     = true
  locale             = "en"
  partial_requests   = true
  discover_region    = ""
  streaming_region   = ""
  original_language  = ""
}

resource "seerr_api_object" "default_quotas" {
  path               = "/api/v1/settings/main"
  read_method        = "GET"
  create_method      = "POST"
  update_method      = "POST"
  delete_method      = "DELETE"
  skip_delete        = true
  suppress_not_found = true

  request_body_json = jsonencode({
    defaultPermissions = 1077936416
    defaultQuotas = {
      movie = {
        quotaDays  = 7
        quotaLimit = 3
      }
      tv = {
        quotaDays  = 7
        quotaLimit = 2
      }
    }
  })

  depends_on = [seerr_main_settings.main]
}

resource "seerr_network_settings" "main" {
  csrf_protection        = false
  force_ipv4_first       = false
  trust_proxy            = false
  api_request_timeout_ms = 10000
}
