# DOCS https://registry.terraform.io/providers/ubiquiti-community/unifi/latest/docs/resources/network
resource "unifi_network" "default" {
  name               = "Main"
  purpose            = "corporate"
  enabled            = true
  auto_scale         = false
  lte_lan            = false
  setting_preference = "manual"

  # IPv4 settings
  subnet = "10.0.0.1/24"

  dhcp_server = {
    enabled            = true
    conflict_checking  = false
    start              = "10.0.0.6"
    stop               = "10.0.0.199"
    dns_enabled        = true
    dns_servers        = [
      "10.20.10.20",
      "1.1.1.1",
      "9.9.9.9",
    ]
    boot = {
      enabled = false
    }
  }

  domain_name   = "home.arpa"
  multicast_dns = true

  ipv6_pd_start    = "::2"
  ipv6_pd_stop     = "::7d1"
  ipv6_ra          = true
  ipv6_ra_priority = "high"

  # Advanced
  network_isolation = false
  internet_access   = true
}

## secondary network
resource "unifi_network" "secondary" {
  name      = "Secondary"
  purpose   = "corporate"
  vlan      = 2
  enabled   = true
  auto_scale = false
  lte_lan    = false

  # IPv4 settings
  subnet = "10.69.69.1/24"

  dhcp_server = {
    enabled           = true
    conflict_checking = false
    start             = "10.69.69.6"
    stop              = "10.69.69.254"
    boot = {
      enabled = false
    }
  }

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  ipv6_pd_start    = "::2"
  ipv6_pd_stop     = "::7d1"
  ipv6_ra          = true
  ipv6_ra_priority = "high"

  # Advanced
  network_isolation = false
  internet_access   = true
}


## Untrusted network
resource "unifi_network" "untrusted" {
  name               = "Untrusted Servers"
  purpose            = "corporate"
  vlan               = 10
  enabled            = true
  auto_scale         = false
  lte_lan            = false
  setting_preference = "manual"

  # IPv4 settings
  subnet = "10.20.10.1/24"

  dhcp_server = {
    enabled           = true
    conflict_checking = false
    start             = "10.20.10.6"
    stop              = "10.20.10.254"
    boot = {
      enabled = false
    }
  }

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  ipv6_pd_start    = "::2"
  ipv6_pd_stop     = "::7d1"
  ipv6_ra          = true
  ipv6_ra_priority = "high"

  # Advanced
  ## TODO: #343 Add firewall rules to only allow access to NAS, or move NAS to this network
  network_isolation = false
  internet_access   = true
}

## IoT network
resource "unifi_network" "iot" {
  name       = "IoT"
  purpose    = "corporate"
  vlan       = 3
  enabled    = true
  auto_scale = false
  lte_lan    = false

  # IPv4 settings
  subnet = "10.10.34.1/24"

  dhcp_server = {
    enabled           = true
    conflict_checking = false
    start             = "10.10.34.6"
    stop              = "10.10.34.254"
    boot = {
      enabled = false
    }
  }

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  ipv6_pd_start    = "::2"
  ipv6_pd_stop     = "::7d1"
  ipv6_ra          = true
  ipv6_ra_priority = "high"

  # Advanced
  network_isolation = false
  internet_access   = true
}

## WAN
# resource "unifi_network" "wan" {
#   name                = "Primary (WAN1)"
#   purpose             = "wan"
#   wan_networkgroup    = "WAN"
#   wan_type            = "dhcp"
#   wan_type_v6         = "disabled"

#   # WAN-specific settings
#   wan_egress_qos      = 0
#   intra_network_access_enabled = false

#   # IPv6 settings
#   ipv6_interface_type          = "none"
#   dhcp_v6_dns_auto             = false
#   dhcp_v6_lease                = 0
#   ipv6_ra_preferred_lifetime  = 0
#   ipv6_ra_valid_lifetime      = 0

#   # DHCP settings
#   dhcp_lease = 0
# }
