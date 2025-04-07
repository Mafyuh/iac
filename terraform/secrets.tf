data "bitwarden_secret" "virtual_environment_endpoint" {
  id = "a4ed343a-bb92-4beb-a421-b2080005bf98"
}

data "bitwarden_secret" "virtual_environment_api" {
  id = "1d250f4a-ae18-4e19-934c-b2080005e132"
}

data "bitwarden_secret" "ssh_password" {
  id = "68f1d77d-4e96-498a-9464-b208000679a4"
}

data "bitwarden_secret" "prox_ip_address" {
  id = "d0c7f3ec-8277-4b1b-9a1b-b2080006b842"
}

data "bitwarden_secret" "pve2_ip_address" {
  id = "17ab7869-c7a1-4ece-8c64-b20800075213"
}

data "bitwarden_secret" "cloudflare_api_token" {
  id = "9b8fa79a-ed9d-4d17-9b73-b2b700663f46"
}