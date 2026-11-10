resource "unifi_wlan" "wifi" {
  name       = "BOP"
  security   = "wpapsk"
  wlan_bands = ["2g", "5g", "6g"]

  # enable WPA2/WPA3 support
  wpa3 = {
    support    = true
    transition = true
  }
  pmf_mode = "optional"

  bss_transition = true

  mac_filter = {
    enabled = false
    policy  = "allow"
  }
  group_rekey = 0

  network_id = unifi_network.iot.id
  ## TODO Import these resources and remove the hardcoded IDs
  user_group_id = "68b5307ec8516827c169f8bb"
  ap_group = {
    ids = ["68b5307ec8516827c169f8c0"]
  }

  lifecycle {
    ignore_changes = [
      passphrase
    ]
  }
}
