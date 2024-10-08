resource "proxmox_virtual_environment_vm" "Docker-Runner2" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 210
    name         = "docker-runner2"
    description  = "docker-runner for forgejo"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 8100
    }
    
    # VM CPU Settings
    cpu {
        cores = 2
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 2048
    }

    # VM Network Settings
    network_device {
        bridge  = "vmbr0"
    }

    # VM Disk Settings
    disk {
        datastore_id = "Fast2Tb"
        size         = 50
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
