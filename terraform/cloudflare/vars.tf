variable "npm_ip_address" {
  type    = string
  default = "10.69.69.200"
}

variable "k3s_nginx_ip_address" {
  type    = string
  default = "10.69.69.220"
}

variable "domains" {
  type = map(string)
  default = {
    xyz = "mafyuh.xyz"
    com = "mafyuh.com"
    dev = "mafyuh.dev"
    io  = "mafyuh.io"
  }
}

variable "access_token" {
  description = "Bitwarden access token"
  type        = string
  sensitive   = true
}
