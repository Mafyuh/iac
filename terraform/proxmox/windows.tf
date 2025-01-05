resource "proxmox_virtual_environment_vm" "Windows11" {
  name      = "windows"
  node_name = "pve2"
  vm_id     = 250
  tags      = ["tofu"]
  started   = true
  bios      = "ovmf"
  machine   = "q35"

  agent {
      enabled = true
    }

  disk {
    datastore_id = "Fast500Gb"
    interface    = "scsi0"
    size         = 50
  }

   cpu {
        cores = 2
        type  = "host"
        architecture = "x86_64"
    }

    memory {
        dedicated = 8192
    }

    efi_disk {
        type = "4m"
    }

    network_device {
        bridge  = "vmbr0"
    }

    tpm_state {
        datastore_id = "Fast500Gb"
        version = "v2.0"
    }

    operating_system {
        type = "win11"
    }

    audio_device {
        enabled = true
    }

    vga {
        memory = 16
        type = "qxl"
    }
}
