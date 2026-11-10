# T3 Code Server
resource "proxmox_virtual_environment_vm" "t3" {
  node_name   = "pve"
  vm_id       = 109
  name        = "t3"
  description = "Ubuntu Server resolute from Packer"
  started     = true
  on_boot     = false
  tags        = ["tofu", "ansible"]

  agent {
    enabled = true
  }

  cpu {
    cores = 6
    type  = "host"
  }

  memory {
    dedicated = 8192
  }

  network_device {
    bridge  = "vmbr0"
    vlan_id = 10
  }

  disk {
    datastore_id = "local-lvm"
    size         = 30
    interface    = "scsi0"
    replicate    = false
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.20.10.106/24"
        gateway = "10.20.10.1"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account,
      initialization[0].user_data_file_id,
    ]
  }

}
