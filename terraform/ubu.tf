resource "proxmox_virtual_environment_vm" "Ubu" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 5000
    name         = "Ubu"
    description  = "My attempt to move things to 1 VM"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 9998
    }
    
    # VM CPU Settings
    cpu {
        cores = 2
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 6144
    }

    # VM Network Settings
    network_device {
        bridge  = "vmbr0"
        vlan_id = 1
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
                address = var.ubu_ip_address
                gateway = var.vlan_gateway
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

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.Ubu.ipv4_addresses[1][0]
}