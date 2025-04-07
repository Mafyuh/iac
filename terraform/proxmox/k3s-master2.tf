resource "proxmox_virtual_environment_vm" "K3s-Master2" {

    # VM General Settings
    node_name    = "pve2"
    vm_id        = 321
    name         = "K3s-Master2"
    description  = "Kubernetes Master"
    tags         = ["tofu", "debian", "infrastructure", "k3s"]
    started      = true

    agent {
      enabled = true # read 'Qemu guest agent' section, change to true only when ready
    }

    clone {
        vm_id = 9999
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
        datastore_id = "Fast500Gb"
        size         = 300
        interface    = "virtio0"
    }

    vga {
        type = "serial0"
    }

    initialization {
        ip_config {
            ipv4 {
                address = data.bitwarden_secret.k3s_master2_ip.value
                gateway = data.bitwarden_secret.vlan_gateway.value
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
