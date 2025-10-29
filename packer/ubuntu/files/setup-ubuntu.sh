#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
set -euo pipefail
set -x

log() {
  echo -e "\n==== $1 ====\n"
}

log "Installing Fastfetch"
wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.29.0/fastfetch-linux-amd64.deb
sudo dpkg -i fastfetch-linux-amd64.deb || echo "dpkg install failed"
rm -f fastfetch-linux-amd64.deb

log "Updating APT and installing packages"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release nfs-common net-tools zsh fzf

log "Changing default shell to zsh for user 'mafyuh'"
sudo chsh -s "$(which zsh)" packer

log "Installing Docker"
curl -fsSL https://get.docker.com | sudo sh

log "Installing Docker Loki plugin"
sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions || echo "Loki plugin install failed"

log "Moving Docker daemon config"
sudo mv /tmp/daemon.json /etc/docker/daemon.json || echo "daemon.json not found or failed to move"

log "Installing Lazydocker"
curl -fsSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

log "Setting system DNS"
sudo mkdir -p /etc/systemd/resolved.conf.d
echo -e '[Resolve]\nDNS=10.20.10.20' | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf

log "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended || echo "Oh My Zsh install failed"

log "Cloning Zsh plugins"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-history-substring-search.git "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"

log "Installing Oh My Posh"
mkdir -p "$HOME/.local/bin"
curl -fsSL https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -o "$HOME/.local/bin/oh-my-posh"
chmod +x "$HOME/.local/bin/oh-my-posh"

log "Downloading Oh My Posh theme"
mkdir -p "$HOME/.oh-my-posh/themes"
curl -fsSL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/sonicboom_dark.omp.json -o "$HOME/.oh-my-posh/themes/sonicboom_dark.omp.json"

log "Setting up Git config"
git config --global user.name "Mafyuh"
git config --global user.email "matt@mafyuh.com"

log "Copying config files to /etc/skel"
sudo cp "$HOME/.zshrc.pre-oh-my-zsh" /etc/skel/.zshrc || echo ".zshrc not found"
sudo cp -r "$HOME/.oh-my-zsh" /etc/skel/
sudo cp -r "$HOME/.oh-my-posh" /etc/skel/
sudo cp -r "$HOME/.local" /etc/skel/
sudo chown -R root:root /etc/skel/.*
