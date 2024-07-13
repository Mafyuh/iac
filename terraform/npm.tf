resource "proxmox_virtual_environment_vm" "NPM" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 204
    name         = "Nginx-Proxy-Manager"
    description  = "Nginx Proxy Manager"
    tags         = ["tofu", "ubuntu24", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
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
        vlan_id = 1
    }

    # VM Disk Settings
    disk {
        datastore_id = "Fast2Tb"
        size         = 40
        interface    = "scsi0"
    }

    vga {
        type = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = var.npm_ip_address
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
