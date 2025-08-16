# DOCS https://registry.terraform.io/providers/ubiquiti-community/unifi/latest/docs/resources/network
resource "unifi_network" "default" {
  name     = "Default"
  purpose  = "corporate"
  vlan_id  = 0
  enabled  = true

  # IPv4 settings
  subnet        = "10.0.0.0/24"
  dhcp_enabled  = true
  dhcp_start    = "10.0.0.6"
  dhcp_stop     = "10.0.0.199"

  # DNS
  dhcp_dns      = [
    "10.20.10.20",
    "1.1.1.1",
    "9.9.9.9",
  ]
  domain_name   = "home.arpa"
  multicast_dns = true

  # IPv6 is diabled but tofu doesnt like if these arent here
  dhcp_v6_start          = "::2"
  dhcp_v6_stop           = "::7d1"
  ipv6_pd_start          = "::2"
  ipv6_pd_stop           = "::7d1"
  ipv6_ra_enable         = true
  ipv6_ra_priority       = "high"
  ipv6_ra_valid_lifetime = 86400

  # Advanced
  intra_network_access_enabled = true
  internet_access_enabled = true
  dhcpd_boot_enabled  = true
  dhcpd_boot_filename  = "pxelinux.0" 
  dhcpd_boot_server  = "10.20.10.2"
}

## Kubernetes network
resource "unifi_network" "kubernetes" {
  name     = "Kubernetes"
  purpose  = "corporate"
  vlan_id  = 2
  enabled  = true

  # IPv4 settings
  subnet        = "10.69.69.0/24"
  dhcp_enabled  = true
  dhcp_start    = "10.69.69.6"
  dhcp_stop     = "10.69.69.254"

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  # IPv6 is diabled but tofu doesnt like if these arent here
  dhcp_v6_start          = "::2"
  dhcp_v6_stop           = "::7d1"
  ipv6_pd_start          = "::2"
  ipv6_pd_stop           = "::7d1"
  ipv6_ra_enable         = true
  ipv6_ra_priority       = "high"
  ipv6_ra_valid_lifetime = 0

  # Advanced
  intra_network_access_enabled = true
  internet_access_enabled = true
  dhcpd_boot_enabled  = true
  dhcpd_boot_filename  = "pxelinux.0" 
  dhcpd_boot_server  = "10.20.10.2"
}


## Untrusted network
resource "unifi_network" "untrusted" {
  name     = "Untrusted Servers"
  purpose  = "corporate"
  vlan_id  = 10
  enabled  = true

  # IPv4 settings
  subnet        = "10.20.10.0/24"
  dhcp_enabled  = true
  dhcp_start    = "10.20.10.6"
  dhcp_stop     = "10.20.10.254"

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  # IPv6 is diabled but tofu doesnt like if these arent here
  dhcp_v6_start          = "::2"
  dhcp_v6_stop           = "::7d1"
  ipv6_pd_start          = "::2"
  ipv6_pd_stop           = "::7d1"
  ipv6_ra_enable         = true
  ipv6_ra_priority       = "high"
  ipv6_ra_valid_lifetime = 0

  # Advanced
  ## TODO: #343 Add firewall rules to only allow access to NAS, or move NAS to this network
  intra_network_access_enabled = true
  internet_access_enabled = true
  dhcpd_boot_enabled  = true
  dhcpd_boot_filename  = "pxelinux.0" 
  dhcpd_boot_server  = "10.20.10.2"
}

## IoT network
resource "unifi_network" "iot" {
  name     = "IoT"
  purpose  = "corporate"
  vlan_id  = 3
  enabled  = true

  # IPv4 settings
  subnet        = "10.10.34.0/24"
  dhcp_enabled  = true
  dhcp_start    = "10.10.34.6"
  dhcp_stop     = "10.10.34.254"

  # DNS
  ## Using Auto which uses the DNS servers from the default network
  multicast_dns = true

  # IPv6 is diabled but tofu doesnt like if these arent here
  dhcp_v6_start          = "::2"
  dhcp_v6_stop           = "::7d1"
  ipv6_pd_start          = "::2"
  ipv6_pd_stop           = "::7d1"
  ipv6_ra_enable         = true
  ipv6_ra_priority       = "high"
  ipv6_ra_valid_lifetime = 0

  # Advanced

  intra_network_access_enabled = true ## Few wifi devices need access to the NAS, so this is enabled for now
  internet_access_enabled = true
  dhcpd_boot_enabled  = true
  dhcpd_boot_filename  = "pxelinux.0" 
  dhcpd_boot_server  = "10.20.10.2"
}

## WAN
resource "unifi_network" "wan" {
  name                = "Primary (WAN1)"
  purpose             = "wan"
  enabled             = false  # This is actually enabled, vice versa for some reason
  wan_networkgroup    = "WAN"
  wan_type            = "dhcp"
  wan_type_v6         = "disabled"

  # WAN-specific settings
  wan_egress_qos      = 0
  intra_network_access_enabled = false

  # IPv6 settings
  ipv6_interface_type          = "none"
  dhcp_v6_dns_auto             = false
  dhcp_v6_lease                = 0
  ipv6_ra_preferred_lifetime  = 0
  ipv6_ra_valid_lifetime      = 0

  # DHCP settings
  dhcp_lease = 0
}
