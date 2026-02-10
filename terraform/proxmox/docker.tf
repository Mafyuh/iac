resource "proxmox_virtual_environment_vm" "docker" {

  # VM General Settings
  node_name   = "prox"
  name        = "docker"
  description = "testing"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]
  started     = true

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
    vlan_id = 2
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 45
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.69.69.25/24"
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
