resource "proxmox_virtual_environment_vm" "Arrbuntu" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 200
    name         = "arrbuntu"
    description  = "arrbuntu"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo", "infrastructure"]

    agent {
      enabled = true 
    }

    clone {
        vm_id = 8000
    }
    
    # VM CPU Settings
    cpu {
        cores = 4
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
        size         = 350
        interface    = "scsi0"
    }

    vga {
        type = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = data.bitwarden-secrets_secret.arrbuntu_ip.value
                gateway = data.bitwarden-secrets_secret.vlan_gateway.value
            }
        }

        user_account {}
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
