#cloud-config
autoinstall:
  version: 1
  locale: en_US
  keyboard:
    layout: us
  identity:
    hostname: ubuntu-noble-template
    username: mafyuh
    password: $6$rounds=4096$dummy$dummy
  storage:
    layout:
      name: direct
  ssh:
    install-server: true
    allow-pw: false
    disable_root: true
    ssh_quiet_keygen: true
    allow_public_ssh_keys: true
  packages:
    - qemu-guest-agent
    - ca-certificates
    - curl
    - git
    - zsh
    - gnupg
    - nfs-common
    - net-tools
    - fzf
  user-data:
    package_upgrade: false
    timezone: America/New_York
    users:
      - name: mafyuh
        groups: [adm, sudo]
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/zsh
        ssh_authorized_keys:
%{ for key in split("\n", ssh_authorized_keys) ~}
          - ${key}
%{ endfor ~}
  early-commands:
    - echo 'Packer build starting' > /tmp/packer-start.log
