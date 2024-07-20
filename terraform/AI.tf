resource "proxmox_virtual_environment_vm" "AI" {

    # VM General Settings
    node_name    = "pve2"
    vm_id        = 322
    name         = "AI"
    machine = "q35"
    description  = "Ollama, Open Webui, mindsdb"
    tags         = ["tofu", "ubuntu-22", "auto-homelab-repo"]
    started      = true

    agent {
      enabled = true 
    }

    clone {
        vm_id = 8101
    }
    
    # VM CPU Settings
    cpu {
        cores = 10
        type  = "host"
        architecture = "x86_64"
    }
    
    # VM Memory Settings
    memory {
        dedicated = 16384
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


    hostpci {
        device = "hostpci0"
        pcie = true
        mapping = "gpu2"
        rombar = true
    }

    initialization {
        ip_config {
            ipv4 {
                address = "dhcp"
            }
        }

        user_data_file_id = proxmox_virtual_environment_file.cloud_config2.id
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
