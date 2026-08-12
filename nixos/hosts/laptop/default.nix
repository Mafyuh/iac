{ config, ... }: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./desktop.nix
    ./packages.nix
  ];

  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  virtualisation.docker.enable = true;

  sops.secrets.bifrost_api_key = {
    sopsFile = ../../secrets/laptop.yaml;
    owner = config.users.users.mafyuh.name;
    group = config.users.users.mafyuh.group;
    mode = "0400";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mafyuh = {
      imports = [ ./home.nix ];
      programs.zsh.initContent = ''
        export BIFROST_API_KEY=$(cat ${config.sops.secrets.bifrost_api_key.path})
      '';
    };
  };
}
