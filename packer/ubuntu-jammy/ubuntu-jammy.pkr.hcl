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
source "proxmox-clone" "ubuntu-server-jammy" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "pve2"

    ## See https://git.mafyuh.dev/mafyuh/iac/src/branch/main/terraform/ubuntu22-template2.tf
    clone_vm_id = "8101"

    vm_id = "9999"
    vm_name = "ubuntu-server-jammy"
    template_description = "Custom Ubuntu Server see https://git.mafyuh.dev/mafyuh/iac/src/branch/main/packer/ubuntu-jammy/ubuntu-jammy.pkr.hcl"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size = "4G"
        format = "raw"
        storage_pool = "Fast500Gb"
        type = "virtio"
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

    name = "ubuntu-server-jammy"
    sources = ["source.proxmox-clone.ubuntu-server-jammy"]

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

    # Install commonly used things - add alias's - set git config
    provisioner "shell" {
        inline = [
            "sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common qemu-guest-agent net-tools zsh neofetch fzf",
            "sudo chsh -s $(which zsh) mafyuh",
            "curl -fsSL https://get.docker.com | sudo sh",
            "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" --unattended",
            "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting",
            "git clone https://github.com/zsh-users/zsh-autosuggestions.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions",
            "git clone https://github.com/zsh-users/zsh-history-substring-search.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search",
            "git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use",
            "mkdir -p /home/mafyuh/.local/bin",
            "curl -fsSL https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o /home/mafyuh/.local/bin/oh-my-posh",
            "sudo chmod +x /home/mafyuh/.local/bin/oh-my-posh",
            "git config --global user.name \"Mafyuh\"",
            "git config --global user.email \"matt@mafyuh.com\"",
            "sudo apt-get -y update"
        ]
    }

    provisioner "file" {
        source = "files/.zshrc"
        destination = "~/.zshrc"
    }

}
