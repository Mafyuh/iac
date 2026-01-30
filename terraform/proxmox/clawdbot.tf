resource "proxmox_virtual_environment_vm" "clawdbot" {

  # VM General Settings
  node_name   = "pve2"
  name        = "clawdbot"
  description = "Clawdbot Server"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]

  agent {
    enabled = true
  }

  clone {
    vm_id = 199
  }

  # VM CPU Settings
  cpu {
    cores        = 3
    type         = "host"
  }

  # VM Memory Settings
  memory {
    dedicated = 4096
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 10
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast500Gb"
    size         = 50
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.20.10.11/24"
        gateway = "10.20.10.1"
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
