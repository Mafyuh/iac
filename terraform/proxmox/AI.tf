resource "proxmox_virtual_environment_vm" "AI" {

    # VM General Settings
    node_name    = "pve2"
    name         = "AI"
    description  = "AI Server"
    machine      = "q35"
    tags         = ["tofu", "ubuntu25", "ansible", "packer"]
    started      = true

    agent {
      enabled = true
    }

    clone {
        vm_id = 19001
    }
    
    # VM CPU Settings
    cpu {
        cores = 8
        type  = "host"
        architecture = "x86_64"
    }

    hostpci {
        device = "hostpci0"
        mapping = "gpu2" # 3080
        pcie = true
    }
    
    # VM Memory Settings
    memory {
        dedicated = 30720
        floating = 6144
    }

    # VM Network Settings
    network_device {
        bridge  = "vmbr0"
        vlan_id = 10
    }

    # VM Disk Settings
    disk {
        datastore_id = "Fast500Gb"
        size         = 150
        interface    = "scsi0"
    }

    vga {
        type = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = "10.20.10.75/24"
                gateway = "10.20.10.1"
            }
        }

        user_data_file_id = proxmox_virtual_environment_file.cloud_config_shared.id
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