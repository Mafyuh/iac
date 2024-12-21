resource "proxmox_virtual_environment_vm" "Tester1" {
    node_name    = "prox"
    vm_id        = "5994"
    name         = "Tester1"
    description  = "Tester1"

    cpu {
        cores = "2"
        type  = "host"
        architecture = "x86_64"
    }

    memory {
        dedicated = "2048"
    }

    network_device {
        bridge  = "vmbr0"
        vlan_id = "null"
    }

    disk {
        datastore_id = "Fast2Tb"
        size         = "20"
        interface    = "scsi0"
    }

    clone {
        vm_id = "9996"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "dhcp"
                vlan_gateway
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
