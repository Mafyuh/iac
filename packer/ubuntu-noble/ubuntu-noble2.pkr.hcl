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
source "proxmox-clone" "ubuntu-server-noble2" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "prox"

    
    clone_vm_id = "8103"

    vm_id = "9996"
    vm_name = "ubuntu-noble-template"
    template_description = "Ubuntu Server Noble"

    # VM System Settings
    qemu_agent = true

    # VM Hard Disk Settings
    scsi_controller = "virtio-scsi-pci"

    disks {
        disk_size = "5G"
        format = "raw"
        storage_pool = "Fast2Tb"
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

    name = "ubuntu-server-noble"
    sources = ["source.proxmox-clone.ubuntu-server-noble2"]

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
            # Install packages and add repositories
            "sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch",
            "sudo apt-get update",
            "sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common net-tools zsh fastfetch fzf",
            # Change default shell to zsh
            "sudo chsh -s $(which zsh) mafyuh",
            # Install Docker
            "curl -fsSL https://get.docker.com | sudo sh",
            # Install Oh My Zsh and plugins
            "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" --unattended",
            "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting",
            "git clone https://github.com/zsh-users/zsh-autosuggestions.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions",
            "git clone https://github.com/zsh-users/zsh-history-substring-search.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search",
            "git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use",
            # Install Oh My Posh
            "mkdir -p /home/mafyuh/.local/bin",
            "curl -fsSL https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o /home/mafyuh/.local/bin/oh-my-posh",
            "sudo chmod +x /home/mafyuh/.local/bin/oh-my-posh",
            # Download posh theme locally
            "mkdir -p /home/mafyuh/.oh-my-posh/themes",
            "curl -fsSL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/sonicboom_dark.omp.json -o /home/mafyuh/.oh-my-posh/themes/sonicboom_dark.omp.json",
            # Setup Git
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
