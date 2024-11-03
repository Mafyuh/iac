resource "proxmox_virtual_environment_vm" "Ubuntu-Noble-Base" {
  name      = "ubuntu-noble-base"
  node_name = "pve2"
  vm_id     = 8102
  tags      = ["tofu", "ubuntu24"]
  template  = true
  started   = false

  disk {
    datastore_id = "local-lvm"
    # See https://www.reddit.com/r/Proxmox/comments/1058ko7/comment/j3s4vli/ for how to inject qemu into base image
    # virt-customize -a noble-server-cloudimg-amd64.img --install qemu-guest-agent
    file_id      = "local:iso/noble-server-cloudimg-amd64.img"
    interface    = "scsi0"
    size         = 5
  }

  agent {
    enabled = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
}

serial_device {}

network_device {
    bridge = "vmbr0"
}

vga {
        type = "serial0"
    }

cpu {
        cores = 2
        type  = "host"
        architecture = "x86_64"
    }
}
