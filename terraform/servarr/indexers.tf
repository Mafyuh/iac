resource "prowlarr_indexer" "usenet_nzbgeek" {
  enable          = true
  name            = "NZBgeek"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://api.nzbgeek.info"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.nzbgeek_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2031-10-17"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}

resource "prowlarr_indexer" "usenet_ninjacentral" {
  enable          = true
  name            = "NinjaCentral"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://ninjacentral.co.za"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.ninjacentral_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2027-04-22"
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
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://api.althub.co.za"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.althub_api_key.value
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

resource "prowlarr_indexer" "usenet_crawler" {
  enable          = false
  name            = "Usenet Crawler"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://www.usenet-crawler.com"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.usenetcrawler_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = ""
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}

resource "prowlarr_indexer" "usenet_drunkenslug" {
  enable          = true
  name            = "DrunkenSlug"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://drunkenslug.com"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.drunkenslug_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2027-09-28"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}

resource "prowlarr_indexer" "usenet_nzblife" {
  enable          = true
  name            = "Nzb.life"
  implementation  = "Newznab"
  config_contract = "NewznabSettings"
  app_profile_id  = 1
  protocol        = "usenet"
  priority        = 25
  redirect        = true
  tags            = []

  fields = [
    {
      name       = "baseUrl"
      text_value = "https://api.nzb.life"
    },
    {
      name       = "apiPath"
      text_value = "/api"
    },
    {
      name            = "apiKey"
      sensitive_value = data.bitwarden-secrets_secret.nzblife_api_key.value
    },
    {
      name       = "vipExpiration"
      text_value = "2027-09-28"
    },
    {
      name         = "baseSettings.limitsUnit"
      number_value = 0
    }
  ]
}
