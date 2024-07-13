resource "proxmox_virtual_environment_vm" "Downloaders" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 201
    name         = "Downloaders"
    description  = "Sab, Qbitty"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 8000
    }
    
    # VM CPU Settings
    cpu {
        cores = 3
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 8192
    }

    # VM Network Settings
    network_device {
        bridge  = "vmbr0"
        vlan_id = 1
    }

    # VM Disk Settings
    disk {
        datastore_id = "Fast2Tb"
        size         = 260
        interface    = "scsi0"
    }

    vga {
        type = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = var.downloaders_ip_address
                gateway = var.vlan_gateway
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
