resource "proxmox_virtual_environment_vm" "K3s-Master2" {

    # VM General Settings
    node_name    = "pve2"
    vm_id        = 321
    name         = "K3s-Master2"
    description  = "Kubernetes Master"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo", "infrastructure"]
    started      = false

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 8005
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
        datastore_id = "local-lvm"
        size         = 100
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
            initialization[0].user_data_file_id
        ]
    }

}
