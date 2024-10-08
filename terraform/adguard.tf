resource "proxmox_virtual_environment_vm" "Adguard" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 206
    name         = "Adguard"
    description  = "DNS Server"
    tags         = ["tofu", "ubuntu24", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = false # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 8002
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
        size         = 60
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

        user_account {}
    }

    lifecycle {
        ignore_changes = [
            initialization[0].user_account[0].keys,
            initialization[0].user_account[0].password,
            initialization[0].user_account[0].username,
        ]
    }

}
