resource "proxmox_virtual_environment_vm" "Kasm2" {
  # VM General Settings
  node_name    = "pve2"
  vm_id        = 102
  name         = "Kasm"
  description  = "kasm"
  tags         = ["tofu", "ubuntu-22", "iac-repo", "ansible"]
  started      = true
  machine      = "q35"
  
  agent {
    enabled = true 
  }

  clone {
    vm_id = 9997
  }
  
  # VM CPU Settings
  cpu {
    cores = 6
    type  = "host"
    architecture = "x86_64"
  }
  
  # VM Memory Settings
  memory {
    dedicated = 8092
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

  vga {
      memory = 16 
      type   = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.69.69.189/24"
        gateway = "10.69.69.1"
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