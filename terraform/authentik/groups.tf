resource "authentik_group" "admin_group" {
  name         = "authentik Admins"
  is_superuser = true
}
resource "authentik_group" "read_only" {
  name         = "authentik Read-only"
  is_superuser = false
  attributes = jsonencode({
    notes = <<-EOT
    An group with an auto-generated role that allows read-only permissions on all objects.
    EOT
  })
}

resource "authentik_group" "jellyfin-ldap" {
  name         = "jellyfin-ldap"
  is_superuser = false
}

resource "authentik_group" "ldapsearch" {
  name         = "ldapsearch"
  is_superuser = false
}

resource "authentik_group" "ldap-sudo" {
  name         = "ldap-sudo"
  is_superuser = false
}
