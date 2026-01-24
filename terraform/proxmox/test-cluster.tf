resource "proxmox_virtual_environment_vm" "test-cluster-1" {

  # VM General Settings
  node_name   = "pve2"
  name        = "test-cluster-1"
  description = "testing"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]

  agent {
    enabled = true
  }

  clone {
    vm_id = 19101
  }

  # VM CPU Settings
  cpu {
    cores        = 4
    type         = "host"
  }

  # VM Memory Settings
  memory {
    dedicated = 8192
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast500Gb"
    size         = 20
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

resource "proxmox_virtual_environment_vm" "test-cluster-2" {

  # VM General Settings
  node_name   = "pve2"
  name        = "test-cluster-2"
  description = "testing"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]

  agent {
    enabled = true
  }

  clone {
    vm_id = 19101
  }

  # VM CPU Settings
  cpu {
    cores        = 4
    type         = "host"
  }

  # VM Memory Settings
  memory {
    dedicated = 8192
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast500Gb"
    size         = 20
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

resource "proxmox_virtual_environment_vm" "test-cluster-3" {

  # VM General Settings
  node_name   = "pve2"
  name        = "test-cluster-3"
  description = "testing"
  tags        = ["tofu", "ubuntu24", "ansible", "packer"]

  agent {
    enabled = true
  }

  clone {
    vm_id = 19101
  }

  # VM CPU Settings
  cpu {
    cores        = 4
    type         = "host"
  }

  # VM Memory Settings
  memory {
    dedicated = 8192
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast500Gb"
    size         = 20
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
