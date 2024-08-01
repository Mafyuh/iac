data "local_file" "ssh_public_key" {
  filename = "/home/mafyuh/.ssh/main_key.pub"
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "Slow4tb"
  node_name    = "prox"

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: mafyuh
        groups:
          - sudo
          - docker
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools nfs-common
        - timedatectl set-timezone America/New_York
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - curl -fsSL https://get.docker.com | sudo sh
        - su - mafyuh -c 'git clone https://git.mafyuh.dev/mafyuh/iac.git /home/mafyuh/iac'
        - su - mafyuh -c 'git config --global user.name "Mafyuh"'
        - su - mafyuh -c 'git config --global user.email "matt@mafyuh.com"'
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config2" {
  content_type = "snippets"
  datastore_id = "Fast500Gb"
  node_name    = "pve2"

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: mafyuh
        groups:
          - sudo
          - docker
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools nfs-common
        - timedatectl set-timezone America/New_York
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - curl -fsSL https://get.docker.com | sudo sh
        - su - mafyuh -c 'git clone https://git.mafyuh.dev/mafyuh/iac.git /home/mafyuh/iac'
        - su - mafyuh -c 'git config --global user.name "Mafyuh"'
        - su - mafyuh -c 'git config --global user.email "matt@mafyuh.com"'
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}