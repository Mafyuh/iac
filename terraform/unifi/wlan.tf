data "unifi_user_group" "default" {
  name = "Default"
}

resource "unifi_wlan" "wifi" {
  name      = "BOP"
  security  = "wpapsk"
  wlan_band = "both"

  # enable WPA2/WPA3 support
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  network_id = unifi_network.iot.id
  ## TODO Import these resources and remove the hardcoded IDs
  user_group_id = "68b5307ec8516827c169f8bb"
  ap_group_ids  = ["68b5307ec8516827c169f8c0"]

  lifecycle {
    ignore_changes = [
      passphrase
    ]
  }
}
