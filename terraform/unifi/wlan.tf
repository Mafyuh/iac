data "unifi_user_group" "default" {
  name = "Default"
}

resource "unifi_wlan" "wifi" {
  name       = "BOP"
  security   = "wpapsk"

  # enable WPA2/WPA3 support
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  network_id    = unifi_network.iot.id
  ## TODO Import these resources and remove the hardcoded IDs
  user_group_id = "683112d62d8c8b784502f3a7"
  ap_group_ids  = ["683112d72d8c8b784502f3ac"]

  lifecycle {
    ignore_changes = [
      passphrase
    ]
  }
}