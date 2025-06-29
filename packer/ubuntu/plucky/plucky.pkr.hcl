packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "ldap_password" {
  type      = string
  sensitive = true
}

# Resource Definiation for the VM Template
source "proxmox-clone" "ubuntu-server-plucky" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "prox"

    
    clone_vm_id = "83266"

    vm_id = "19000"
    vm_name = "ubuntu-plucky-template"
    template_description = "Ubuntu Server plucky"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    ## This inherits the disk from the template, having this adds scsi1
    # disks {
    #     disk_size = "5G"
    #     format = "qcow2"
    #     storage_pool = "NAS"
    #     type = "scsi"
    # }

    # VM CPU Settings
    cores = "2"
    cpu_type = "x86-64-v2-AES"
    
    # VM Memory Settings
    memory = "2048" 

    # VM Network Settings
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    }
    

    ssh_username = "packer"
    # WSL Filesystem
    ssh_private_key_file = "~/.ssh/id_rsa"
}


build {
    name = "ubuntu-server-plucky"
    sources = ["source.proxmox-clone.ubuntu-server-plucky"]

    ## Cleanup for re-template
    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /var/lib/dbus/machine-id",
            "sudo rm -f /var/lib/systemd/random-seed",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync"
        ]
    }

    provisioner "file" {
        source = "ubuntu/files/pve.cfg"
        destination = "/tmp/pve.cfg"
    }

    provisioner "shell" {
        inline = [ "sudo cp /tmp/pve.cfg /etc/cloud/cloud.cfg.d/pve.cfg" ]
    }

    provisioner "file" {
        source = "ubuntu/files/daemon.json"
        destination = "/tmp/daemon.json"
    }

    provisioner "file" {
        source = "ubuntu/files/sssd.conf"
        destination = "/tmp/sssd.conf"
    }

    provisioner "file" {
        source = "ubuntu/files/setup-ubuntu.sh"
        destination = "/tmp/setup-ubuntu.sh"
    }

    provisioner "file" {
        source = "ubuntu/files/.zshrc"
        destination = "~/.zshrc"
    }

    
    provisioner "shell" {
        inline = [
            "chmod +x /tmp/setup-ubuntu.sh",
            "sed -i 's/PLACEHOLDER_PASSWORD/${var.ldap_password}/g' /tmp/sssd.conf",
            "/tmp/setup-ubuntu.sh"
        ]
    }
}

## Same thing as above just different node and vm_id
source "proxmox-clone" "ubuntu-server-plucky2" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "pve2"

    
    clone_vm_id = "83266"

    vm_id = "19001"
    vm_name = "ubuntu-plucky-template"
    template_description = "Ubuntu Server plucky"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

## This inherits the disk from the template, having this adds scsi1
    # disks {
    #     disk_size = "5G"
    #     format = "qcow2"
    #     storage_pool = "NAS"
    #     type = "scsi"
    # }

    # VM CPU Settings
    cores = "2"
    cpu_type = "x86-64-v2-AES"
    
    # VM Memory Settings
    memory = "2048" 

    # VM Network Settings
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    }
    

    ssh_username = "packer"
    # WSL Filesystem
    ssh_private_key_file = "~/.ssh/id_rsa"
}


build {

    name = "ubuntu-server-plucky"
    sources = ["source.proxmox-clone.ubuntu-server-plucky2"]

    ## Cleanup for re-template
    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /var/lib/dbus/machine-id",
            "sudo rm -f /var/lib/systemd/random-seed",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync"
        ]
    }

    provisioner "file" {
        source = "ubuntu/files/pve.cfg"
        destination = "/tmp/pve.cfg"
    }

    provisioner "shell" {
        inline = [ "sudo cp /tmp/pve.cfg /etc/cloud/cloud.cfg.d/pve.cfg" ]
    }

    provisioner "file" {
        source = "ubuntu/files/daemon.json"
        destination = "/tmp/daemon.json"
    }

    provisioner "file" {
        source = "ubuntu/files/sssd.conf"
        destination = "/tmp/sssd.conf"
    }

    provisioner "file" {
        source = "ubuntu/files/setup-ubuntu.sh"
        destination = "/tmp/setup-ubuntu.sh"
    }

    provisioner "file" {
        source = "ubuntu/files/.zshrc"
        destination = "~/.zshrc"
    }

    
    provisioner "shell" {
        inline = [
            "chmod +x /tmp/setup-ubuntu.sh",
            "sed -i 's/PLACEHOLDER_PASSWORD/${var.ldap_password}/g' /tmp/sssd.conf",
            "/tmp/setup-ubuntu.sh"
        ]
    }
}