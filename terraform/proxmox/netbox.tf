resource "proxmox_virtual_environment_vm" "netbox" {
  # VM General Settings
  node_name    = "pve2"
  name         = "netbox"
  description  = "netbox"
  tags         = ["tofu", "ubuntu24", "iac-repo", "ansible"]
  started      = true
  
  agent {
    enabled = true 
  }

  clone {
    vm_id = 9997
  }
  
  # VM CPU Settings
  cpu {
    cores = 2
    type  = "host"
    architecture = "x86_64"
  }
  
  # VM Memory Settings
  memory {
    dedicated = 4096
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 1
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast500Gb"
    size         = 40
    interface    = "scsi0"
  }

  vga {
      memory = 16 
      type   = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.69.69.175/24"
        gateway = "10.69.69.1"
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