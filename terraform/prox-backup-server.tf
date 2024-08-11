resource "proxmox_virtual_environment_vm" "PBS" {
  # VM General Settings
  node_name    = "prox"
  vm_id        = 10000
  name         = "PBS"
  description  = "Proxmox Backup Server"
  tags         = ["tofu", "iac-repo"]
  started      = true
  
  agent {
    enabled = false 
  }
  
  # VM CPU Settings
  cpu {
    cores = 2
    type  = "host"
    architecture = "x86_64"
  }
  
  # VM Memory Settings
  memory {
    dedicated = 2048
  }

  # VM Network Settings
  network_device {
    bridge  = "vmbr0"
  }

  # VM Disk Settings
  disk {
    datastore_id = "Fast2Tb"
    interface    = "scsi0"
    size         = 32
    file_format  = "raw"
  }

  disk {
    datastore_id = "Slow4tb"
    interface    = "scsi1"
    size         = 2048
    file_format  = "raw"
  }
}