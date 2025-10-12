resource "authentik_outpost" "embedded_outpost" {
  name = "authentik Embedded Outpost"
  protocol_providers = [
    authentik_provider_proxy.grafana.id,
    56,
    68,
  ]
  service_connection = authentik_service_connection_kubernetes.local.id
}

resource "authentik_outpost" "ldap" {
  name = "LDAP"
  type = "ldap"
  protocol_providers = [
    authentik_provider_ldap.jellyfin.id,
    authentik_provider_ldap.ldap.id,
    70,
  ]
  service_connection = authentik_service_connection_kubernetes.local.id
}

resource "authentik_service_connection_kubernetes" "local" {
  name  = "Local Kubernetes Cluster"
  local = true
}