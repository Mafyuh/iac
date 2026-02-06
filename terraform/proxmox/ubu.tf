resource "proxmox_virtual_environment_vm" "Ubu" {

  # VM General Settings
  node_name   = "prox"
  vm_id       = 5000
  name        = "Ubu"
  description = "My attempt to move things to 1 VM"
  tags        = ["tofu", "ubuntu-22", "ansible"]

  agent {
    enabled = true # read 'Qemu guest agent' section, change to true only when ready
  }

  clone {
    vm_id = 9998
  }

  # VM CPU Settings
  cpu {
    cores        = 4
    type         = "host"
    architecture = "x86_64"
  }

  # VM Memory Settings
  memory {
    dedicated = 16384
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 2
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast2Tb"
    size         = 120
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.69.69.2/24"
        gateway = data.bitwarden-secrets_secret.vlan_gateway.value
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config_shared.id
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
