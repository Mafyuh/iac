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
    # System administration
    btop
    docker
    dmidecode
    tlp
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  home-manager.users.mafyuh.home.packages = with pkgs; [
    # Dev + infra
    nodejs
    pre-commit
    kubernetes-helm
    terraform
    wget
    yadm
    jq
    oci-cli
    github-cli
    pkgs-unstable.grok-build
    pkgs-unstable.claude-code
    pkgs-unstable.codex
    pkgs-unstable.fluxcd
    pkgs-unstable.k9s
    pkgs-unstable.kubectl
    pkgs-unstable.opencode
    pkgs-unstable.t3code
    pkgs-unstable.vscode
    wireguard-tools

    # Desktop
    bottles
    unityhub
    pkgs-unstable.vscode
    pkgs-unstable.brave
    pkgs-unstable.discord
    pkgs-unstable.termius
    kdePackages.plasma-browser-integration
    vlc

    # Shell
    fastfetch
    nerd-fonts.fira-code
    oh-my-posh
    pay-respects

    # Talos
    pkgs-unstable.talhelper
    pkgs-unstable.talosctl
  ];
}
