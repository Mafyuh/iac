resource "proxmox_virtual_environment_vm" "Runner" {

  # VM General Settings
  node_name    = "prox"
  vm_id        = 952
  name         = "Runner"
  description  = "Forgejo Runner for iac"
  tags         = ["tofu", "ubuntu-22", "iac-repo", "infrastructure"]

  agent {
    enabled = true
  }

  clone {
    vm_id = 9996
  }
  
  # VM CPU Settings
  cpu {
    cores        = 2
    type         = "host"
    architecture = "x86_64"
    flags        = []
  }
  
  # VM Memory Settings
  memory {
    dedicated = 2048
  }

  # VM Network Settings
  network_device {
    bridge       = "vmbr0"
    model        = "virtio"
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast2Tb"
    size         = 50
    interface    = "scsi0"
    file_format  = "raw"
    path_in_datastore = "vm-952-disk-0" 
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = "Slow4tb:snippets/cloud-config.yaml"
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account,
      initialization[0].user_data_file_id,
      cpu[0].flags,
      disk[0].file_format, 
      disk[0].path_in_datastore,
    ]
  }

}
