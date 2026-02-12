resource "proxmox_virtual_environment_vm" "ollama" {

  # VM General Settings
  node_name   = "pve2"
  name        = "ollama"
  description = "ollama"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]
  started     = true
  machine = "q35"

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
    dedicated = 8192
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 2
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 75
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  hostpci {
    device = "hostpci0"
    mapping = "gpu2"
    pcie = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.69.69.50/24"
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
