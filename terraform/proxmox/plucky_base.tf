resource "proxmox_virtual_environment_vm" "Ubuntu-plucky-Base" {
  name      = "ubuntu-plucky-base"
  node_name = "pve2"
  tags      = ["tofu", "ubuntu25", "packer"]
  template  = true
  started   = false

  disk {
    datastore_id = "NAS"
    file_id      = "NAS:iso/plucky-server-cloudimg-qemu-amd64.img"
    interface    = "scsi0"
    size         = 5
  }

  agent {
    enabled = true
  }

  initialization {
    datastore_id = "NAS"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_init_qemu.id
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
        #architecture = "x86_64"
    }
}
