resource "proxmox_virtual_environment_vm" "Ubuntu-22-Template" {
  name      = "ubuntu-22"
  node_name = "prox"
  vm_id     = 8100
  tags      = ["tofu", "ubuntu-22"]
  template  = true
  started   = false

  disk {
    datastore_id = "Fast2Tb"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image_22.id
    interface    = "scsi0"
    size         = 4
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

  user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
}

serial_device {}

network_device {
    bridge = "vmbr0"
}

vga {
        type = "serial0"
    }

}


resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image_22" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "prox"
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}
