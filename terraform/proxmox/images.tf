# resource "proxmox_virtual_environment_download_file" "ubuntu_plucky_cloud_image" {
#   content_type       = "iso"
#   datastore_id       = "NAS"
#   file_name          = "plucky-server-cloudimg-amd64.img"
#   node_name          = "prox"
#   url                = "https://cloud-images.ubuntu.com/plucky/20250627/plucky-server-cloudimg-amd64.img"
#   checksum           = "da142696698ab0bdc60630c18d9570cf30f36b32a9a2f8f91bb8f37fadeec31d"
#   checksum_algorithm = "sha256"
#   overwrite          = false
# }

# resource "proxmox_download_file" "ubuntu_resolute_cloud_image" {
#   content_type       = "iso"
#   datastore_id       = "local"
#   file_name          = "ubuntu-26.04-live-server-amd64.iso"
#   node_name          = "pve"
#   url                = "https://releases.ubuntu.com/26.04/ubuntu-26.04-live-server-amd64.iso"
#   checksum           = "dec49008a71f6098d0bcfc822021f4d042d5f2db279e4d75bdd981304f1ca5d9"
#   checksum_algorithm = "sha256"
#   overwrite          = false
#   verify             = false
# }