# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_group
resource "cloudflare_zero_trust_access_group" "usa_access_group" {
  name       = "USA"
  account_id = data.bitwarden_secret.cf_account_id.value
  exclude    = []
  require    = []
  is_default = true

  include = [
    {
      geo = {
        country_code = "US"
      }
    }
  ]
}
