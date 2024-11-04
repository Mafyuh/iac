locals {
  ssh_public_key_1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDndt2pi7jZx0qY1qn/UEn2AcZThxCQBvIGNytlPDz1cFNHjB1lGgHdI4uCw7fu2ET6/vpqHxjdQqB/Ehj2fajw1L2zncKB93NMv3pcq7ZJGwIgdw26vfBQZWFazaPk7O5rOGO1hWohE4YlejpOHYGCFs1pUxaC8DQPR0M6GvnccWxzJhpiO+NUeU8F/NC1uKLyypK8CpTmjVQaiTSgn/RorTf7A6sdzfWFndM7k6hw5NqqKVk0OhDfy/XCGQrIRh6/yxFbbthAUJgd8/djELlc7XQaG0nMSBtu6m8+VmMN8XO7FZmus8PwlcXPIhwos+vJlh2+xU+E7Ciwyw4WytCjuw67rL4REbdOh+zqZm//OMswvTxtDiRbTXTsOXqgyh5cOUcNub3UdAl6e7c2ZQT5lz5ZVCNNLVrFigvRE813YlKsoYu1p4XrtyHodeYEXgoLjU0jgRj0EmBEDriafo84lamHK7zItZllNH9hHKWs+iXiQQ4nVD65Ng0mYmM9OF76corqfIuQWkQd8kN2r5a0UHrl+tkhZOY3x3PB9r88yCPRdSkW8ICFObQ069yE4HU9kA41rVPXOU8zxK8UT2svTM0YRcDcfr2VUktU0wEP1ASv8nOAdvq7+pcqpoKrw3sZyyeLncxSAfJCRMjJvUDww92YSTjG4TCwY2gcPXRsww== Generated By Termius"
  ssh_public_key_2 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCt9kj7JcJVf8zfzLlsDv12d9dV7J4SM+Wrq7fWMUseCzl7BK3SX+cNFYWbkZsDsp81VtXrqXDpImIGc9KtRy1tvNmrd/+xlj6aVFH9tHYq//5pOC2C4wcf3wVlSazdhZ64qVwY4glr1Bs4M02GZ92VDjb51JvByl5kfgiKLqRiFyJHv9f5FYEfZqdLY+SKjd7H6fjhMTFTcyfXeGaifUTqogDXPLzk0iP0rx7C3oHOfsKKhZvUe/la9uYJGdbSeQX1H59KOVJQ7UQxr7wn+uu5e7IPPXiBoR4dBU8pAmtWgLo9F0ZdXgu2bOunUBIeL2/dj6xFCI3ZrQ3mLe+upoyhqLKh4+qi5SeQNcqXi7pHhcA1hGzmOMDrPXV/2DA0NcJ6v43qJFRn+Qp8Oy/zApvQ6F/opLhX0yghEc5ltmj+MPMom4ykKxpuGPUHxNplMgmVG+V/YlRXG9BATsQX35kt2lqivX9L4XppgJHhby0bJnZQKozExCn67w1rSW7MvYyo/W7aXK7ZGLIeH7sxqwwisQlbMjhVzYcods1p+JDi1VhNQUsc4nDA0ghk9PiSY11pwAvvzds46wZLMrxlNeIs2cEdghIi+5QO68qvZHODHrtiAn3yJ7qjarx5qOx5oe2DX2duY6/7cUEnwQFNX5z4hfeCCThz9jIn316Jk/oeXQ== admin@mafyuh.io"
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
          - ${trimspace(local.ssh_public_key_1)}
          - ${trimspace(local.ssh_public_key_2)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt upgrade -y
        - timedatectl set-timezone America/New_York
        - su - mafyuh -c 'git clone https://git.mafyuh.dev/mafyuh/iac.git /home/mafyuh/iac'
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
          - ${trimspace(local.ssh_public_key_1)}
          - ${trimspace(local.ssh_public_key_2)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt upgrade -y
        - timedatectl set-timezone America/New_York
        - su - mafyuh -c 'git clone https://git.mafyuh.dev/mafyuh/iac.git /home/mafyuh/iac'
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}