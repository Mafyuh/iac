resource "proxmox_virtual_environment_vm" "TrueNAS" {

  node_name    = "prox"
  vm_id        = 100
  name         = "TrueNAS"
  machine      = "q35"

  # VM General Settings
  tags = [
    "debian",
    "infrastructure",
  ]
  
  # CPU Settings
  cpu {
    cores        = 6
    type         = "qemu64"
    sockets      = 1
    units        = 1024
    architecture = "x86_64"
  }

  # Memory Settings
  memory {
    dedicated = 8192
  }

  # Network Settings
  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    firewall    = true
  }

  # Operating System Settings
  operating_system {
    type = "l26"
  }

  # VGA Settings
  vga {
    type   = "std"
    memory = 16
  }

  # Startup Settings
  startup {
    order      = 1
    down_delay = -1
    up_delay   = -1
  }

  # Additional Settings
  scsi_hardware           = "virtio-scsi-pci"
  keyboard_layout         = "en-us"
  on_boot                 = true
  migrate                 = false
  stop_on_destroy         = false
  reboot                  = false

  # Timeout Settings
  timeout_clone           = 1800
  timeout_create          = 1800
  timeout_migrate         = 1800
  timeout_reboot          = 1800
  timeout_shutdown_vm     = 1800
  timeout_start_vm        = 1800
  timeout_stop_vm         = 300
  
  # I do not consider this import done. Alot of things need updating on here (4 HDD's are connected)

  lifecycle {
    ignore_changes = [
      scsi_hardware,
      keyboard_layout,
      on_boot,
      migrate,
      stop_on_destroy,
      reboot,
      vga,
      cpu,
      timeout_clone,
      timeout_create,
      timeout_migrate,
      timeout_move_disk,
      timeout_reboot,
      timeout_shutdown_vm,
      timeout_start_vm,
      timeout_stop_vm,
    ]
  }

}
