data "unifi_user_group" "default" {
  name = "Default"
}

data "unifi_ap_group" "default" {
  name = "default"
}

resource "unifi_wlan" "wifi" {
  name      = "BOP"
  security  = "wpapsk"
  wlan_band = "both"

  # enable WPA2/WPA3 support
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  network_id    = unifi_network.iot.id
  user_group_id = data.unifi_user_group.default.id
  ap_group_ids  = [data.unifi_ap_group.default.id]

  lifecycle {
    ignore_changes = [
      passphrase
    ]
  }
}
