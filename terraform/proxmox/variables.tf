# Define each required variable
variable "arrbuntu_ip_address" {
  description = "IP address for Arrbuntu VM"
  type        = string
}

variable "init_username" {
  description = "Username for initial configuration"
  type        = string
}

variable "downloaders_ip_address" {
  description = "IP address for Downloaders VM"
  type        = string
}

variable "npm_ip_address" {
  description = "IP address for NPM VM"
  type        = string
}

variable "prox_ip_address" {
  description = "IP address for Proxmox server"
  type        = string
}

variable "kasm_ssh_ip" {
  description = "IP address for Kasm SSH"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "vlan_gateway" {
  description = "Gateway IP for VLAN"
  type        = string
}

variable "virtual_environment_endpoint" {
  description = "Endpoint for virtual environment API"
  type        = string
}

variable "kasm_ip" {
  description = "IP address for Kasm"
  type        = string
}

variable "ssh_username" {
  description = "Username for SSH access"
  type        = string
}

variable "init_password" {
  description = "Password for initial configuration"
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
}

variable "pve2_ip_address" {
  description = "IP address for PVE2 Proxmox server"
  type        = string
}

variable "s3_endpoint" {
  description = "Endpoint for S3 storage"
  type        = string
}

variable "ubu_ip_address" {
  description = "IP address for Ubu VM"
  type        = string
}

variable "virtual_environment_api" {
  description = "API endpoint for virtual environment"
  type        = string
}

variable "ssh_password" {
  description = "Password for SSH access"
  type        = string
  sensitive   = true
}
