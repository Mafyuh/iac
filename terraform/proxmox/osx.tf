resource "proxmox_virtual_environment_vm" "osx" {
    node_name    = "prox"
    vm_id        = "107"
    name         = "osx"
    description  = "osx"
    started      = true

    cpu {
        cores = "3"
        type  = "host"
        architecture = "x86_64"
    }

    memory {
        dedicated = "4096"
    }

    network_device {
        bridge  = "vmbr0"
        vlan_id = 1
    }

    disk {
        datastore_id = "Fast2Tb"
        size         = "50"
        interface    = "scsi0"
    }

    clone {
        vm_id = "9996"
    }

    vga {
      memory = 16 
      type   = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "dhcp"
            }
        }

        user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
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
