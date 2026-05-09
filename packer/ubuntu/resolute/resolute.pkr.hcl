packer {
  required_plugins {
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
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

source "proxmox-iso" "ubuntu-server-resolute" {

    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true

    # VM General Settings
    node = "pve"

    vm_id = "199"
    vm_name = "ubuntu-26-template"
    template_description = "Ubuntu Server resolute from Packer"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        type = "scsi"
        disk_size = "8G"
        storage_pool = "local-lvm"
    }

    boot_iso {
        type = "scsi"
        iso_file = "local:iso/ubuntu-26.04-live-server-amd64.iso"
        unmount = true
        iso_checksum = "sha256:dec49008a71f6098d0bcfc822021f4d042d5f2db279e4d75bdd981304f1ca5d9"
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
    ssh_private_key_file = "~/.ssh/id_ed"

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
      "/meta-data" = "instance-id: packer\nlocal-hostname: ubuntu-resolute-template"
    }
    http_port_min = 8001
    http_port_max = 8001
}


build {

    name = "ubuntu-server-resolute"
    sources = ["source.proxmox-iso.ubuntu-server-resolute"]

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

    provisioner "shell" {
        inline = [
            "curl -fsSL https://get.docker.com | sudo sh",
            "curl -fsSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash"
        ]
    }

    provisioner "ansible-local" {
        playbook_file = "../../ansible/playbooks/zsh.yml"
        extra_arguments = ["-e", "ansible_user=mafyuh"]
    }

    provisioner "shell" {
        inline = [
            "sudo usermod -aG docker mafyuh",
            "sudo mkdir -p /etc/systemd/resolved.conf.d",
            "echo -e '[Resolve]\\nDNS=10.20.10.20' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf",
            "git config --global user.name 'Mafyuh'",
            "git config --global user.email 'matt@mafyuh.com'",
            "sudo cp -r $HOME/.oh-my-zsh /etc/skel/ 2>/dev/null || true",
            "sudo cp -r $HOME/.oh-my-posh /etc/skel/ 2>/dev/null || true",
            "sudo cp -r $HOME/.local /etc/skel/ 2>/dev/null || true"
        ]
    }

}

locals {
  user_data = templatefile("../files/cloud-init.pkrtpl.hcl", {
    ssh_authorized_keys = join("\n", var.ssh_authorized_keys)
  })
}
