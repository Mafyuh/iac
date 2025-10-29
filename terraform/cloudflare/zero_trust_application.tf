# TODO: Removed from state, keeps bugging out but should be mostly correct
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application#nestedatt--saas_app
# Also have more to add (wildcard)

# resource "cloudflare_zero_trust_access_application" "openwebui" {
#   account_id                    = "e123cacbf24b8b0dbb0598d81be2e319"
#   domain                        = "chat.${var.domains["io"]}"
#   type                          = "self_hosted"
#   allow_authenticate_via_warp   = false
#   allowed_idps                  = [
#     "a3a920bd-99e4-45a9-8c8b-c24abd686164"
#   ]
#   destinations = [
#     {
#       type       = "public"
#       uri        = "chat.${var.domains["io"]}"
#     }
#   ]
#   enable_binding_cookie         = true
#   http_only_cookie_attribute    = true
#   name                          = "Open WebUI"
#   options_preflight_bypass      = true
#   policies = [
#     {
#       id          = "8f07b241-9cf6-40e2-bb5d-71ca1ebfb5b6"
#       name        = "USA"
#       decision    = "allow"
#       exclude     = []
#       include = [
#         {
#           geo = {
#             country_code = "US"
#           }
#         }
#       ]
#       precedence = 1
#     }
#   ]
#   self_hosted_domains           = [
#     "chat.${var.domains["io"]}"
#   ]
#   service_auth_401_redirect     = false
#   session_duration              = "336h"
#   skip_interstitial             = true
#   skip_app_launcher_login_page  = true
#   tags                          = []

# }
