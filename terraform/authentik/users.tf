resource "authentik_user" "main" {
  username = "mafyuh"
  name     = "Matt"
  email    = "admin@${var.domains["io"]}"
  groups   = [authentik_group.jellyfin-ldap.id, authentik_group.admin_group.id, authentik_group.ldap-sudo.id]
  attributes = jsonencode({
    settings = {
        theme = {
            base = "dark"
        }
    }
  })
}