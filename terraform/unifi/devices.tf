resource "unifi_device" "cgf" {
  name              = "CGF"
  allow_adoption    = true
  forget_on_destroy = false
  mac               = "a8:9c:6c:94:af:e8"
}

resource "unifi_device" "pro_xg_8_poe" {
  name              = "USW Pro XG 8 PoE"
  allow_adoption    = true
  forget_on_destroy = false
  mac               = "8c:ed:e1:b0:81:00"
}

resource "unifi_device" "flex_2_5g_5" {
  name              = "USW Flex 2.5G 5"
  allow_adoption    = true
  forget_on_destroy = false
  mac               = "a8:9c:6c:18:04:e4"
}

resource "unifi_device" "u7_pro_xg" {
  name              = "U7 Pro XG"
  allow_adoption    = true
  forget_on_destroy = false
  mac               = "8c:30:66:84:3b:98"
}

resource "unifi_device" "u5g_backup" {
  name              = "U5G Backup"
  allow_adoption    = true
  forget_on_destroy = false
  mac               = "74:f9:2c:b2:87:7c"
}
