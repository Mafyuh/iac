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

# Resource Definiation for the VM Template
source "proxmox-clone" "debian" {

    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true

    # VM General Settings
    node = "prox"


    clone_vm_id = "8104"

    vm_id = "9998"
    vm_name = "debian-template"
    template_description = "Debian Bullseye"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size = "3G"
        format = "raw"
        storage_pool = "Fast2Tb"
        type = "scsi"
    }

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


    ssh_username = "mafyuh"
    # WSL Filesystem
    ssh_private_key_file = "~/.ssh/id_rsa"
}


build {

    name = "debian"
    sources = ["source.proxmox-clone.debian"]

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
        source = "files/pve.cfg"
        destination = "/tmp/pve.cfg"
    }

    provisioner "shell" {
        inline = [ "sudo cp /tmp/pve.cfg /etc/cloud/cloud.cfg.d/pve.cfg" ]
    }


    provisioner "shell" {
    inline = [
        "sudo apt-get update",
        "sudo mkdir -p /etc/systemd/resolved.conf.d && echo '[Resolve]\nDNS=1.1.1.1' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf",
        "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y open-iscsi nfs-common cryptsetup",
        "sudo apt-get -y upgrade"
    ]
    }

}
