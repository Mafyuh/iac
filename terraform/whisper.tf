resource "proxmox_virtual_environment_vm" "Whisper" {

    # VM General Settings
    node_name    = "prox"
    vm_id        = 203
    name         = "Whisper"
    machine = "q35"
    description  = "Creates subtitles for Bazarr and stable-diffusion"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo"]
    started      = false

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 8000
    }
    
    # VM CPU Settings
    cpu {
        cores = 2
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 4096
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

    hostpci {
        device = "hostpci0"
        pcie = true
        mapping = "gpu"
        rombar = true
    }

    initialization {
        ip_config {
            ipv4 {
                address = var.whisper_ip_address
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
            initialization[0].user_data_file_id
        ]
    }

}
