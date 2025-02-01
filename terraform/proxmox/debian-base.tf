resource "proxmox_virtual_environment_vm" "Debian-Base" {
  name      = "debian-base"
  node_name = "prox"
  vm_id     = 8104
  tags      = ["tofu"]
  template  = true
  started   = false

  disk {
    datastore_id = "Fast2Tb"
    # See https://www.reddit.com/r/Proxmox/comments/1058ko7/comment/j3s4vli/ for how to inject qemu into base image
    # virt-customize -a debian-11-generic-amd64-20241202-1949.img --install qemu-guest-agent
    file_id      = "local:iso/debian-11-generic-amd64-20241202-1949.img"
    interface    = "virtio0"
    size         = 3
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
