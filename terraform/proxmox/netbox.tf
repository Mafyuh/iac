resource "proxmox_virtual_environment_container" "netbox" {
  node_name   = "pve2"
  start_on_boot = true
  unprivileged = true

  description = "netbox"

  tags = []

  operating_system {
    type = "debian"
    template_file_id = "SATA500:debian-12-standard_12.7-1_amd64.tar.zst"
  }

  disk {
    datastore_id = "SATA500"
    size         = 45
  }

  cpu {
    architecture = "amd64"
    cores        = 4
    units        = 1024
  }

  memory {
    dedicated = 4096
    swap      = 512
  }

  network_interface {
    name        = "eth0"
    bridge      = "vmbr0"
    enabled     = true
    firewall    = false
    mac_address = "BC:24:11:76:53:DF"
    mtu         = 0
    rate_limit  = 0
    vlan_id     = 10
  }

  initialization {
    hostname = "netbox"

    dns {
      servers = ["10.0.0.40"]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }

  lifecycle {
    ignore_changes = [
      operating_system[0].template_file_id
    ]
 }
}