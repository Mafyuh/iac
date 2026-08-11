{ ... }: {
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mafyuh = import ./home.nix;
  };
}
