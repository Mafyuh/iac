# resource "authentik_source_oauth" "discord" {
#   name                = "Discord"
#   slug                = "discord"
#   authentication_flow = data.authentik_flow.default-source-authentication.id
#   enrollment_flow     = null

#   provider_type   = "discord"
#   consumer_key    = "1132849371034161203"
#   consumer_secret = null
# }
## Oauth Sources need consumer key, need to create secrets
## Proton, Azure, Google, Github, Reddit need to be added