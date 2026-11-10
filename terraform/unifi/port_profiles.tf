resource "unifi_port_profile" "poe_disabled" {
  autoneg               = true
  forward               = "all"
  full_duplex           = true
  isolation             = false
  setting_preference    = "manual"
  name                  = "POE Disabled"
  native_networkconf_id = unifi_network.default.id
  op_mode               = "switch"
  poe_mode              = "off"
  stp_port_mode         = true
  tagged_vlan_mgmt      = "auto"

  dot1x = {
    ctrl         = "auto"
    idle_timeout = "5m0s"
  }

  egress_rate_limit = {
    enabled = false
  }

  lldpmed = {
    enabled        = true
    notify_enabled = false
  }

  port_security = {
    enabled = false
  }

  stormctrl = {
    bcast = {
      enabled = false
    }
    mcast = {
      enabled = false
    }
    ucast = {
      enabled = false
    }
  }
}

resource "unifi_port_profile" "poe_enabled" {
  autoneg               = true
  forward               = "all"
  full_duplex           = true
  isolation             = false
  setting_preference    = "manual"
  name                  = "POE Enabled"
  native_networkconf_id = unifi_network.default.id
  op_mode               = "switch"
  poe_mode              = "auto"
  stp_port_mode         = true
  tagged_vlan_mgmt      = "auto"

  dot1x = {
    ctrl         = "auto"
    idle_timeout = "5m0s"
  }

  egress_rate_limit = {
    enabled = false
  }

  lldpmed = {
    enabled        = true
    notify_enabled = false
  }

  port_security = {
    enabled = false
  }

  stormctrl = {
    bcast = {
      enabled = false
    }
    mcast = {
      enabled = false
    }
    ucast = {
      enabled = false
    }
  }
}
