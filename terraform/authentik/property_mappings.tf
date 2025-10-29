## Scope Mappings
resource "authentik_property_mapping_provider_scope" "email" {
  name        = "authentik default OAuth Mapping: OpenID 'email'"
  scope_name  = "email"
  description = "Email address"
  expression  = <<EOF
return {
    "email": request.user.email,
    "email_verified": True
}
EOF
}

resource "authentik_property_mapping_provider_scope" "openid" {
  name       = "authentik default OAuth Mapping: OpenID 'openid'"
  scope_name = "openid"
  expression = <<EOF
return {}
EOF
}

resource "authentik_property_mapping_provider_scope" "profile" {
  name        = "authentik default OAuth Mapping: OpenID 'profile'"
  scope_name  = "profile"
  description = "General Profile Information"
  expression  = <<EOF
return {
    # Because authentik only saves the user's full name, and has no concept of first and last names,
    # the full name is used as given name.
    # You can override this behaviour in custom mappings, i.e. `request.user.name.split(" ")`
    "name": request.user.name,
    "given_name": request.user.name,
    "preferred_username": request.user.username,
    "nickname": request.user.username,
    "groups": [group.name for group in request.user.ak_groups.all()],
}
EOF
}

## This is just needed to map superusers in Netbox to authentik admins. Only admins can access netbox
resource "authentik_property_mapping_provider_scope" "netbox" {
  name       = "Netbox roles"
  scope_name = "roles"
  expression = <<EOF
return {
  "groups": [
    "superusers" if group.name == "authentik Admins"
    else "staff" if group.name == "jellyfin-ldap"
    else group.name
    for group in request.user.ak_groups.all()
  ]
}
EOF
}

## SAML
resource "authentik_property_mapping_provider_saml" "email" {
  name       = "authentik default SAML Mapping: Email"
  saml_name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
  expression = "return request.user.email"
}

resource "authentik_property_mapping_provider_saml" "groups" {
  name       = "authentik default SAML Mapping: Groups"
  saml_name  = "http://schemas.xmlsoap.org/claims/Group"
  expression = "for group in request.user.ak_groups.all():\n    yield group.name"
}

resource "authentik_property_mapping_provider_saml" "name" {
  name       = "authentik default SAML Mapping: Name"
  saml_name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
  expression = "return request.user.name"
}

resource "authentik_property_mapping_provider_saml" "upn" {
  name       = "authentik default SAML Mapping: UPN"
  saml_name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn"
  expression = "return request.user.attributes.get('upn', request.user.email)"
}

resource "authentik_property_mapping_provider_saml" "uid" {
  name       = "authentik default SAML Mapping: User ID"
  saml_name  = "http://schemas.goauthentik.io/2021/02/saml/uid"
  expression = "return request.user.pk"
}

resource "authentik_property_mapping_provider_saml" "username" {
  name       = "authentik default SAML Mapping: Username"
  saml_name  = "http://schemas.goauthentik.io/2021/02/saml/username"
  expression = "return request.user.username"
}

resource "authentik_property_mapping_provider_saml" "windowsacct" {
  name       = "authentik default SAML Mapping: WindowsAccountname (Username)"
  saml_name  = "http://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname"
  expression = "return request.user.username"
}
