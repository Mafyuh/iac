resource "authentik_outpost" "embedded_outpost" {
  name = "authentik Embedded Outpost"
  protocol_providers = [
    authentik_provider_proxy.bazarr.id,
    48,
    37,
    9,
    authentik_provider_proxy.grafana.id,
    27,
    16,
    19,
    18,
    15,
    56,
  ]
  service_connection = "9c001843-74cb-4548-ba03-a986c6a27abc"
}