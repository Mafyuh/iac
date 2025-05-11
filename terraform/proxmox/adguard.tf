resource "proxmox_virtual_environment_vm" "adguard" {
    node_name    = "prox"
    name         = "adguard"
    description  = "adguard server"
    vm_id        = 122
    tags         = ["tofu", "ubuntu24", "ansible"]

    cpu {
        cores = "2"
        type  = "host"
        architecture = "x86_64"
    }

    agent {
        enabled = true
    }

    memory {
        dedicated = "2048"
    }

    network_device {
        bridge  = "vmbr0"
    }

    disk {
        datastore_id = "Fast2Tb"
        size         = "23"
        interface    = "scsi0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "10.0.0.40/24"
                gateway = "10.0.0.1"
            }
        }

        user_data_file_id = proxmox_virtual_environment_file.cloud_config_shared.id
    }

    vga {
      memory = 16 
      type   = "serial0"
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
