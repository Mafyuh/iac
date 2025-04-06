## TODO: Constant errors trying to apply these
# resource "cloudflare_page_rule" "request_forward" {
#   zone_id  = 
#   target   = "https://request.${var.io_domain}/*"
#   priority = 3
#   status   = "active"
#   actions {
#     forwarding_url {
#       url         = "https://request.${var.dev_domain}/"
#       status_code = 301
#     }
#   }
# }


# resource "cloudflare_page_rule" "auth_page_rule1" {
#   priority = 2
#   status   = "active"
#   target   = "https://auth.${var.io_domain}/api/v3/"
#   zone_id  = 
#   actions {
#     browser_check = "off"
#   }
# }

# resource "cloudflare_page_rule" "auth_page_rule2" {
#   priority = 1
#   status   = "active"
#   target   = "https://auth.${var.io_domain}/application/o/*/jwks/"
#   zone_id  = 
#   actions  {
#     browser_check = "off"
#   }
# }