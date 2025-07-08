#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# Exit on error
set -e

# Install packages and add repositories
wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.29.0/fastfetch-linux-amd64.deb
sudo dpkg -i fastfetch-linux-amd64.deb
rm -f fastfetch-linux-amd64.deb
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common sssd ldap-utils net-tools zsh fzf

# Change default shell to zsh
sudo chsh -s $(which zsh) packer

# Install Docker & Loki Plugin
curl -fsSL https://get.docker.com | sudo sh
sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
sudo mv /tmp/daemon.json /etc/docker/daemon.json
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Set DNS
sudo mkdir -p /etc/systemd/resolved.conf.d && echo '[Resolve]\nDNS=10.20.10.20' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf

# Install Oh My Zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use

# Install Oh My Posh
mkdir -p $HOME/.local/bin
curl -fsSL https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o $HOME/.local/bin/oh-my-posh
sudo chmod +x $HOME/.local/bin/oh-my-posh


# Download posh theme locally
mkdir -p $HOME/.oh-my-posh/themes
curl -fsSL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/sonicboom_dark.omp.json -o $HOME/.oh-my-posh/themes/sonicboom_dark.omp.json

# Setup Git
git config --global user.name "Mafyuh"
git config --global user.email "matt@mafyuh.com"

## SSSD Setup
sudo mv /tmp/sssd.conf /etc/sssd/sssd.conf
sudo chmod 600 /etc/sssd/sssd.conf
sudo chown root:root /etc/sssd/sssd.conf
sudo systemctl enable sssd
sudo systemctl start sssd
sudo sed -i 's/^#\?\s*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?\s*PermitEmptyPasswords.*/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?\s*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i '/^#\?\s*AuthorizedKeysCommand/s|.*|AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys|' /etc/ssh/sshd_config
sudo sed -i '/^#\?\s*AuthorizedKeysCommandUser/s|.*|AuthorizedKeysCommandUser nobody|' /etc/ssh/sshd_config
echo '%ldap-sudo ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ldap-sudo
sudo chmod 440 /etc/sudoers.d/ldap-sudo
echo 'session required pam_mkhomedir.so skel=/etc/skel umask=0022' | sudo tee -a /etc/pam.d/common-session

# Copy configurations to skel
sudo cp $HOME/.zshrc.pre-oh-my-zsh /etc/skel/.zshrc
sudo cp -r $HOME/.oh-my-zsh /etc/skel/
sudo cp -r $HOME/.oh-my-posh /etc/skel/
sudo cp -r $HOME/.local /etc/skel/
sudo chown -R root:root /etc/skel/.*

sudo tee /etc/motd > /dev/null <<'EOF'

╔══════════════════════════════════════════════════════════════╗
║                    WARNING: MONITORING IN PROGRESS           ║
╠══════════════════════════════════════════════════════════════╣
║ This system is connected to LDAP via Authentik               ║
║ All activities are logged and monitored                      ║
╚══════════════════════════════════════════════════════════════╝

┌──────────────────────────────────────────────────────────────┐
│                     SYSTEM INFORMATION                       │
├──────────────────────────────────────────────────────────────┤
│ • Default shell: zsh (with oh-my-zsh modifications)          │
│ • Sudo access: Granted via 'ldap-sudo' group                 │
│   - Run `id` to check your groups                            │
│   - If 'ldap-sudo' is missing, contact Matt                  │
├──────────────────────────────────────────────────────────────┤
│                      QUICK COMMANDS                          │
├──────────────────────────────────────────────────────────────┤
│ • Check aliases:        alias                                │
│ • Change shell:         chsh -s /bin/bash                    │
│ • System info:          hostnamectl                          │
└──────────────────────────────────────────────────────────────┘

EOF
