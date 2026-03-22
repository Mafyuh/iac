resource "proxmox_virtual_environment_vm" "Runner" {

  # VM General Settings
  node_name   = "pve"
  vm_id       = 104
  name        = "Runner"
  description = "Forgejo Runner for iac"
  tags        = ["tofu", "ubuntu-22", "iac-repo", "ansible"]

  agent {
    enabled = true
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
    bridge = "vmbr0"
    model  = "virtio"
  }

  # VM Disk Settings
  # disk {
  #   datastore_id      = "local-lvm"
  #   size              = 50
  #   interface         = "scsi0"
  # }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.0.0.206/24"
        gateway = "10.0.0.1"
      }
    }
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
