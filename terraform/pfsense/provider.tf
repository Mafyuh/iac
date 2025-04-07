# terraform {
#   required_providers {
#     pfsense = {
#       source  = "marshallford/pfsense"
#       version = "0.15.0"
#     }
#     bitwarden = {
#       source  = "maxlaverse/bitwarden"
#       version = "0.13.5"
#     }
#   }
# }

# provider "pfsense" {
#   url             = "https://10.0.0.1"
#   password        = data.bitwarden_secret.pfsense_password.value
#   tls_skip_verify = true
# }