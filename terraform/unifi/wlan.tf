data "unifi_ap_group" "all" {
  name = "All APs"
}

data "unifi_client_qos_rate" "default" {
  name = "Default"
}

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

  network_id    = unifi_network.iot.id
  user_group_id = data.unifi_client_qos_rate.default.id
  ap_group = {
    ids = [data.unifi_ap_group.all.id]
  }

  lifecycle {
    ignore_changes = [
      passphrase
    ]
  }
}
