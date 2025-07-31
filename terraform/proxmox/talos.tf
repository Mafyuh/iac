# resource "proxmox_virtual_environment_vm" "talos-cp1" {

#     # VM General Settings
#     node_name    = "prox"
#     name         = "talos-cp1"
#     description  = "Talos Control Plane"
#     tags         = ["tofu", "talos"]
#     migrate      = true
#     started      = true
#     vm_id        = 20001
#     agent {
#       enabled = true
#     }
#     # VM CPU Settings
#     cpu {
#         cores = 2
#         type  = "host"
#         architecture = "x86_64"
#     }
#     # VM Memory Settings
#     memory {
#         dedicated = 2048
#     }
#     # VM Network Settings
#     network_device {
#         bridge  = "vmbr0"
#         vlan_id = 10
#     }

#     # VM Disk Settings
#     disk {
#         datastore_id = "Fast2Tb"
#         size         = 30
#         interface    = "scsi0"
#         import_from  = proxmox_virtual_environment_download_file.talos_image.id
#     }
# }

# resource "proxmox_virtual_environment_vm" "talos-cp2" {
#     # VM General Settings
#     node_name    = "pve2"
#     name         = "talos-cp2"
#     description  = "Talos Linux Template"
#     tags         = ["tofu", "talos"]
#     migrate      = true
#     started      = true
#     vm_id        = 20002
#     agent {
#       enabled = true
#     }
#     # VM CPU Settings
#     cpu {
#         cores = 2
#         type  = "host"
#         architecture = "x86_64"
#     }
#     # VM Memory Settings
#     memory {
#         dedicated = 2048
#     }
#     # VM Network Settings
#     network_device {
#         bridge  = "vmbr0"
#         vlan_id = 10
#     }
#     # VM Disk Settings
#     disk {
#         datastore_id = "local-lvm"
#         size         = 30
#         interface    = "scsi0"
#         import_from  = proxmox_virtual_environment_download_file.talos_image.id
#     }
# }

# resource "proxmox_virtual_environment_vm" "talos-cp3" {

#     # VM General Settings
#     node_name    = "prox"
#     name         = "talos-cp3"
#     description  = "Talos Control Plane"
#     tags         = ["tofu", "talos"]
#     migrate      = true
#     started      = true
#     vm_id        = 20003
#     agent {
#       enabled = true
#     }
#     # VM CPU Settings
#     cpu {
#         cores = 2
#         type  = "host"
#         architecture = "x86_64"
#     }
#     # VM Memory Settings
#     memory {
#         dedicated = 2048
#     }
#     # VM Network Settings
#     network_device {
#         bridge  = "vmbr0"
#         vlan_id = 10
#     }

#     # VM Disk Settings
#     disk {
#         datastore_id = "Fast2Tb"
#         size         = 30
#         interface    = "scsi0"
#         import_from  = proxmox_virtual_environment_download_file.talos_image.id
#     }
# }