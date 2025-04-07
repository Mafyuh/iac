resource "prowlarr_indexer" "usenet_ninjacentral" {
  enable          = true
  name            = "NinjaCentral"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 1
  tags            = []

  fields = [
    {
      name       = "baseUrl",
      text_value = "https://ninjacentral.co.za"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden_secret.ninjacentral_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2026-04-16"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}

resource "prowlarr_indexer" "usenet_nzbgeek" {
  enable          = true
  name            = "NZBgeek"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 1
  tags            = []

  fields = [
    {
      name       = "baseUrl",
      text_value = "https://api.nzbgeek.info"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden_secret.nzbgeek_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2025-10-15"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}

resource "prowlarr_indexer" "usenet_althub" {
  enable          = true
  name            = "altHUB"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 1
  tags            = []

  fields = [
    {
      name       = "baseUrl",
      text_value = "https://api.althub.co.za"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden_secret.althub_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2027-01-10"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}