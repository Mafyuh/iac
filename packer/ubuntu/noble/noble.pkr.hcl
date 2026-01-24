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

variable "ssh_authorized_keys" {
  type      = list(string)
  sensitive = true
}

source "proxmox-iso" "ubuntu-server-noble" {

    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true

    # VM General Settings
    node = "pve2"

    vm_id = "199"
    vm_name = "ubuntu-24-template"
    template_description = "Ubuntu Server noble from Packer"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        type = "scsi"
        disk_size = "8G"
        storage_pool = "NAS"
    }

    boot_iso {
        type = "scsi"
        iso_file = "NAS:iso/ubuntu-24.04.3-live-server-amd64.iso"
        unmount = true
        iso_checksum = "sha512:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
    }

    # VM CPU Settings
    cores = "3"
    cpu_type = "host"

    # VM Memory Settings
    memory = "4096"

    # VM Network Settings
    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    }

    cloud_init              = true
    cloud_init_storage_pool = "local-lvm"


    ssh_username = "mafyuh"
## The build takes forever, 60 is more than enough
    ssh_timeout  = "60m"
    # WSL Filesystem
    ssh_private_key_file = "~/.ssh/id_rsa"

    boot_wait = "10s"
    boot_command = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]

    http_content = {
      "/user-data" = local.user_data
      "/meta-data" = "instance-id: packer\nlocal-hostname: ubuntu-noble-template"
    }
    http_port_min = 8001
    http_port_max = 8001
}


build {

    name = "ubuntu-server-noble"
    sources = ["source.proxmox-iso.ubuntu-server-noble"]

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
        source = "ubuntu/files/setup-ubuntu.sh"
        destination = "/tmp/setup-ubuntu.sh"
    }


    provisioner "shell" {
        inline = [
            "chmod +x /tmp/setup-ubuntu.sh",
            "/tmp/setup-ubuntu.sh"
        ]
    }

    provisioner "file" {
        source = "ubuntu/files/.zshrc"
        destination = "~/.zshrc"
    }
}

locals {
  user_data = templatefile("../files/cloud-init.pkrtpl.hcl", {
    ssh_authorized_keys = join("\n", var.ssh_authorized_keys)
  })
}
