{ pkgs, pkgs-unstable, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };
  environment.systemPackages = with pkgs; [
    btop
    docker
    tlp
    dmidecode
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  home-manager.users.mafyuh.home.packages = with pkgs; [
    wget
    terraform
    freelens-bin
    kubernetes-helm
    kubectl
    fluxcd
    oci-cli
    wireguard-tools
    pkgs-unstable.claude-code
    pkgs-unstable.opencode
    pkgs-unstable.discord
    pkgs-unstable.codex
    pkgs-unstable.termius
    pkgs-unstable.k9s
    pkgs-unstable.vscode
    pkgs-unstable.brave
    bottles
    unityhub
    pay-respects
    fastfetch
    oh-my-posh
    nerd-fonts.fira-code
    kdePackages.plasma-browser-integration
    yadm
    vlc
    jq
  ];
}
