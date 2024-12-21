resource "proxmox_virtual_environment_vm" "Test" {
    node_name    = "prox"
    vm_id        = "5656"
    name         = "Test"
    description  = "Test"

    cpu {
        cores = "2"
        type  = "host"
    }

    memory {
        dedicated = "2048"
    }

    network_device {
        bridge  = "vmbr0"
        vlan_id = "1"
    }

    disk {
        datastore_id = "Fast2Tb"
        size         = "20"
    }

    clone {
        vm_id = "9996"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "dhcp"
            }
        }

        user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
    }
}
