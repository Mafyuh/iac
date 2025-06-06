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
source "proxmox-clone" "ubuntu-server-plucky" {
 
    # Proxmox Connection Settings
    proxmox_url = "${var.proxmox_api_url}"
    username = "${var.proxmox_api_token_id}"
    token = "${var.proxmox_api_token_secret}"
    insecure_skip_tls_verify = true
    
    # VM General Settings
    node = "prox"

    
    clone_vm_id = "84518"

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
    

    ssh_username = "mafyuh"
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

    
    provisioner "shell" {
        inline = [
            # Install packages and add repositories
            "wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.29.0/fastfetch-linux-amd64.deb",
            "sudo dpkg -i fastfetch-linux-amd64.deb",
            "rm -f fastfetch-linux-amd64.deb",
            "sudo apt-get update",
            "sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common net-tools zsh fzf",
            # Change default shell to zsh
            "sudo chsh -s $(which zsh) mafyuh",
            # Install Docker & Loki Plugin
            "curl -fsSL https://get.docker.com | sudo sh",
            "sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions",
            "sudo mv /tmp/daemon.json /etc/docker/daemon.json",
            # Set DNS
            "sudo mkdir -p /etc/systemd/resolved.conf.d && echo '[Resolve]\nDNS=10.0.0.40' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf",
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
            "sudo apt-get -y upgrade"
        ]
    }

    provisioner "file" {
        source = "ubuntu/files/.zshrc"
        destination = "~/.zshrc"
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

    
    clone_vm_id = "84518"

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
    

    ssh_username = "mafyuh"
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

    
    provisioner "shell" {
        inline = [
            # Install packages and add repositories
            "wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.29.0/fastfetch-linux-amd64.deb",
            "sudo dpkg -i fastfetch-linux-amd64.deb",
            "rm -f fastfetch-linux-amd64.deb",
            "sudo apt-get update",
            "sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common net-tools zsh fzf",
            # Change default shell to zsh
            "sudo chsh -s $(which zsh) mafyuh",
            # Install Docker & Loki Plugin
            "curl -fsSL https://get.docker.com | sudo sh",
            "sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions",
            "sudo mv /tmp/daemon.json /etc/docker/daemon.json",
            # Set DNS
            "sudo mkdir -p /etc/systemd/resolved.conf.d && echo '[Resolve]\nDNS=10.0.0.40' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf",
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
            "sudo apt-get -y upgrade"
        ]
    }

    provisioner "file" {
        source = "ubuntu/files/.zshrc"
        destination = "~/.zshrc"
    }

}