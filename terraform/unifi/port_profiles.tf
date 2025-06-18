resource "unifi_port_profile" "poe_disabled" {
  autoneg                        = true
  dot1x_ctrl                     = "auto"
  dot1x_idle_timeout             = 300
  egress_rate_limit_kbps_enabled = false
  forward                        = "all"
  full_duplex                    = true
  isolation                      = false
  lldpmed_enabled                = true
  name                           = "POE Disabled"
  native_networkconf_id          = unifi_network.default.id
  op_mode                        = "switch"
  poe_mode                       = "off"
  port_security_enabled          = false
  stormctrl_bcast_enabled        = false
  stormctrl_mcast_enabled        = false
  stormctrl_ucast_enabled        = false
  stp_port_mode                  = true
  tagged_vlan_mgmt               = "auto"
}

resource "unifi_port_profile" "poe_enabled" {
  autoneg                        = true
  dot1x_ctrl                     = "auto"
  dot1x_idle_timeout             = 300
  egress_rate_limit_kbps_enabled = false
  forward                        = "all"
  full_duplex                    = true
  isolation                      = false
  lldpmed_enabled                = true
  name                           = "POE Enabled"
  native_networkconf_id          = unifi_network.default.id
  op_mode                        = "switch"
  poe_mode                       = "auto"
  port_security_enabled          = false
  stormctrl_bcast_enabled        = false
  stormctrl_mcast_enabled        = false
  stormctrl_ucast_enabled        = false
  stp_port_mode                  = true
  tagged_vlan_mgmt               = "auto"
}