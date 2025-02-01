resource "proxmox_virtual_environment_vm" "Kasm" {
  # VM General Settings
  node_name    = "pve2"
  vm_id        = 333
  name         = "Kasm"
  description  = "kasm"
  tags         = ["tofu", "ubuntu-22", "iac-repo"]
  started      = true
  machine      = "q35"
  
  agent {
    enabled = true 
  }

  clone {
    vm_id = 9999
  }
  
  # VM CPU Settings
  cpu {
    cores = 6
    type  = "host"
    architecture = "x86_64"
  }
  
  # VM Memory Settings
  memory {
    dedicated = 16384
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 1
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 149
    interface    = "scsi0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = data.bitwarden-secrets_secret.kasm_ip.value
        gateway = data.bitwarden-secrets_secret.vlan_gateway.value
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config2.id
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