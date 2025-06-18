resource "unifi_device" "dream_router" {
  name              = "Dream Router 7"
  allow_adoption    = true
  forget_on_destroy = true

  port_override {
    number              = 5
    name                = "10GB Link"
  }

  port_override {
    number              = 1
    name                = "Main PC"
    poe_mode            = "off"
  }

  port_override {
    number              = 3
    name                = "Port 3"
  }

  port_override {
    number = 4
    name   = "WAN"
  }

## Getting Error: api.err.NotSupportQosConfig (400 ) for PUT https://10.0.0.1/proxy/network/api/s/default/rest/device
## will update this once i look into it more
  lifecycle {
    ignore_changes = [
      port_override
    ]
  }
}



resource "unifi_device" "flex_poe_8" {
  name              = "USW Flex 2.5G 8 PoE"
  allow_adoption    = true
  forget_on_destroy = false
  port_override {
    number              = 9
    name                = "PoE Injector Power In"
    op_mode             = "switch"
  }

  port_override {
    number              = 1
    name                = "Port 1"
    op_mode             = "switch"
    poe_mode            = "off"
  }

  port_override {
    number              = 2
    name                = "Port 2"
    poe_mode            = "auto"
    port_profile_id     = unifi_port_profile.poe_enabled.id
  }

  port_override {
    number              = 3
    name                = "Port 3"
    op_mode             = "switch"
    poe_mode            = "off"
  }

  port_override {
    number              = 4
    name                = "Port 4"
    op_mode             = "switch"
    poe_mode            = "off"
  }

  port_override {
    number              = 5
    name                = "Port 5"
    op_mode             = "switch"
    poe_mode            = "off"
  }

  port_override {
    number              = 6
    name                = "AP"
    poe_mode            = "auto"
    port_profile_id     = unifi_port_profile.poe_enabled.id
  }

  port_override {
    number              = 7
    name                = "Port 7"
    op_mode             = "switch"
    poe_mode            = "off"
  }

  port_override {
    number              = 8
    name                = "Port 8"
    op_mode             = "switch"
    poe_mode            = "off"
  }
}
