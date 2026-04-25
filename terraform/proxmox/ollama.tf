resource "proxmox_virtual_environment_vm" "ollama" {

  # VM General Settings
  node_name   = "pve"
  name        = "ollama"
  description = "ollama"
  tags        = ["tofu", "ubuntu26", "ansible", "packer"]
  started     = true
  machine     = "q35"
  on_boot     = false

  agent {
    enabled = true
  }

  clone {
    vm_id = 199
  }

  # VM CPU Settings
  cpu {
    cores        = 12
    type         = "host"
  }

  # VM Memory Settings
  memory {
    dedicated = 6144
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 10
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 100
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  hostpci {
    device = "hostpci0"
    mapping = "gtx1660"
    pcie = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.20.10.55/24"
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
