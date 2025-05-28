resource "authentik_outpost" "embedded_outpost" {
  name = "authentik Embedded Outpost"
  protocol_providers = [
    authentik_provider_proxy.bazarr.id,
    authentik_provider_proxy.lidarr.id,
    authentik_provider_proxy.grafana.id,
    authentik_provider_proxy.sonarr.id,
    authentik_provider_proxy.prowlarr.id,
    authentik_provider_proxy.sabnzbd.id,
    authentik_provider_proxy.radarr.id,
    56,
  ]
  service_connection = authentik_service_connection_kubernetes.local.id
}

resource "authentik_outpost" "ldap" {
  name = "LDAP"
  type = "ldap"
  protocol_providers = [
    authentik_provider_ldap.jellyfin.id,
    authentik_provider_ldap.ldap.id,
  ]
  service_connection = authentik_service_connection_kubernetes.local.id
}

resource "authentik_service_connection_kubernetes" "local" {
  name  = "Local Kubernetes Cluster"
  local = true
}