# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.local/bin

# Set theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git ubuntu copypath copyfile dirhistory zsh-interactive-cd docker docker-compose opentofu zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting you-should-use)

source $ZSH/oh-my-zsh.sh

# Set up Oh My Posh
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/sonicboom_dark.omp.json)"

# Custom aliases
alias dcd="docker compose down"
alias dcu="docker compose up -d"

# Display system information
neofetch
