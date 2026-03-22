## Coming back to this
# resource "proxmox_virtual_environment_haresource" "blockyHA" {
#   resource_id  = "vm:${proxmox_virtual_environment_vm.blockyHA.vm_id}"
#   group        = "main-nodes"
#   state        = "started"
# }

resource "proxmox_virtual_environment_vm" "blockyHA" {

  # VM General Settings
  node_name   = "pve"
  name        = "blocky-HA"
  description = "blocky DNS server HA"
  tags        = ["tofu", "ubuntu25", "ansible", "packer"]
  migrate     = true
  started     = true

  agent {
    enabled = true
  }

  # VM CPU Settings
  cpu {
    cores        = 2
    type         = "host"
    architecture = "x86_64"
  }

  # VM Memory Settings
  memory {
    dedicated = 2048
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
    vlan_id = 10
  }

  # VM Disk Settings
  disk {
    datastore_id = "local-lvm"
    size         = 30
    interface    = "scsi0"
  }

  vga {
    type = "serial0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "10.20.10.20/24"
        gateway = "10.20.10.1"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account[0].keys,
      initialization[0].user_account[0].password,
      initialization[0].user_account[0].username,
      initialization[0].user_data_file_id
    ]
  }

}
