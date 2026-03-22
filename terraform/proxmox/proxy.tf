resource "proxmox_virtual_environment_vm" "proxy" {

  # VM General Settings
  node_name   = "pve"
  name        = "proxy"
  description = "Isolated Reverse Proxy for Jellyfin"
  tags        = ["tofu", "ubuntu25", "ansible", "packer"]
  started     = true

  agent {
    enabled = true
  }

  # VM CPU Settings
  cpu {
    cores        = 2
    type         = "host"
    architecture = "x86_64"
  }

  # VM Memory Settings
  memory {
    dedicated = 2048
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 6
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 30
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account[0].keys,
      initialization[0].user_account[0].password,
      initialization[0].user_account[0].username,
      initialization[0].user_data_file_id
    ]
  }

}
