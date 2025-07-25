resource "authentik_user" "main" {
  username = "mafyuh"
  name     = "Matt"
  email    = "admin@${var.domains["io"]}"
  groups   = [authentik_group.jellyfin-ldap.id, authentik_group.admin_group.id, authentik_group.ldap-sudo.id]
  attributes = jsonencode({
    sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC2I9wGjs+G/RO5aJJDNL0j5yPExvX7RETQIO6OmXbvx Generated By Termius "
  })
}