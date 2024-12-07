resource "proxmox_virtual_environment_vm" "Plausible" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 103
    name         = "Plausible"
    description  = "Plausible"
    tags         = ["tofu", "ubuntu24", "iac-repo", "infrastructure"]

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 9996
    }
    
    # VM CPU Settings
    cpu {
        cores = 3
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 4196
    }

    # VM Network Settings
    network_device {
        bridge  = "vmbr0"
        vlan_id = 1
    }

    # VM Disk Settings
    disk {
        datastore_id = "Fast2Tb"
        size         = 30
        interface    = "scsi0"
    }

    vga {
        type = "serial0"
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