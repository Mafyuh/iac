resource "proxmox_virtual_environment_vm" "Plausible" {
    node_name    = "prox"
    vm_id        = "7894"
    name         = "umami"
    description  = "Website tracker"
    tags         = ["tofu", "ubuntu24", "ansible"]

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
        vlan_id = 2
    }

    disk {
        datastore_id = "Fast2Tb"
        size         = "30"
        interface    = "scsi0"
    }

    clone {
        vm_id = "9996"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "10.69.69.199/24"
                gateway = "10.69.69.1"
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
