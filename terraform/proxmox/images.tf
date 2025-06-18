resource "proxmox_virtual_environment_download_file" "ubuntu_plucky_cloud_image" {
  content_type       = "iso"
  datastore_id       = "NAS"
  file_name          = "plucky-server-cloudimg-amd64.img"
  node_name          = "prox"
  url                = "https://cloud-images.ubuntu.com/plucky/20250508/plucky-server-cloudimg-amd64.img"
  checksum           = "7010bcc253919ca1b287cab7848eafc845038eb8837b3b88f4ce1df865767a43"
  checksum_algorithm = "sha256"
  overwrite          = false
}

## Need to run this on pve2 to inject qemu-guest-agent into the image
## cp plucky-server-cloudimg-amd64.img plucky-server-cloudimg-qemu-amd64.img
## virt-customize -a plucky-server-cloudimg-qemu-amd64.img --install qemu-guest-agent
## plucky-server-cloudimg-qemu-amd64.img is then used in packer + opentofu for templates


