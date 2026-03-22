resource "proxmox_virtual_environment_vm" "omni" {

  # VM General Settings
  node_name   = "pve"
  name        = "omni"
  description = "testing"
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
    dedicated = 4096
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 2
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
        address = "10.69.69.169/24"
        gateway = "10.69.69.1"
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
