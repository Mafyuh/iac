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
