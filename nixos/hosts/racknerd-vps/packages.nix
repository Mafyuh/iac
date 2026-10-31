{ pkgs, pkgs-unstable, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    docker_29
    lazydocker
    python315
  ];

  # Ansible (expects /usr/bin/python3
  systemd.tmpfiles.rules = [
    "L+ /usr/bin/python3 - - - - /run/current-system/sw/bin/python3"
  ];
}
