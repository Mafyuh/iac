data "bitwarden-secrets_secret" "seerr_api_key" {
  id = "9f3c9356-b984-42a8-aa29-b3e80014f1a7"
}

data "bitwarden-secrets_secret" "jellyfin_api_key" {
  id = "73fea9a5-a8d7-430d-99da-b4be00366783"
}

data "bitwarden-secrets_secret" "radarr_api_key" {
  id = "04771fc9-038d-44a3-8bb9-b2580049ba61"
}

data "bitwarden-secrets_secret" "sonarr_api_key" {
  id = "eb97b60f-f7f1-4f37-b6c9-b258004aca85"
}

data "bitwarden-secrets_secret" "email_password" {
  id = "791a973c-b7b9-45e2-9d83-b448001f4436"
}

data "bitwarden-secrets_secret" "pushover_access_token" {
  id = "9e0c6929-c670-4678-92da-b4be003667b9"
}

data "bitwarden-secrets_secret" "pushover_user_token" {
  id = "22bbcd04-596a-4218-9d12-b4be003667e9"
}

data "bitwarden-secrets_secret" "webhook_url" {
  id = "b53de256-9469-49e7-aeb8-b4be00366815"
}

data "bitwarden-secrets_secret" "jellyfin_external_url" {
  id = "f2960ddd-ed8c-46ac-b07b-b4be00382af2"
}
