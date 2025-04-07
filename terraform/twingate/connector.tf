resource "twingate_remote_network" "homelab_network" {
  name = "Homelab"
  location = "ON_PREMISE"
}

resource "twingate_connector" "homelab_connector" {
  remote_network_id = twingate_remote_network.homelab_network.id
  status_updates_enabled = true
  name = "charming-eel"
}