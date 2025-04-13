resource "authentik_provider_oauth2" "cloudflare" {
  name      = "Provider for Cloudflare"
  client_id = "HaRwyfeUlBCzdypqDU7hhsYTy7Ndaa4kyypQaK9A"

  authentication_flow  = null
  invalidation_flow    = data.authentik_flow.default-invalidation-flow.id
  authorization_flow   = data.authentik_flow.default-explicit-authorization-flow.id
  access_token_validity = "minutes=5"
  signing_key          = data.authentik_certificate_key_pair.generated.id

  property_mappings = [
    "4b0c926e-abed-4c70-bd8d-2a32af2b0bba",
    "079ca9d7-277b-4341-981c-61d5969cf211",
    "f3ccb1f7-555a-4cbe-b4be-f38805d03b58",
  ]

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://mafyuh.cloudflareaccess.com/cdn-cgi/access/callback"
    }
  ]
}


resource "authentik_application" "cloudflare" {
  name              = "Cloudflare"
  slug              = "cloudflare"
  protocol_provider = authentik_provider_oauth2.cloudflare.id
  meta_description   = "Cloudflare Access (Logs into Open WebUI, authentik)"
  meta_icon        = "/media/public/application-icons/cloudflare1.svg"
}