variable "domains" {
  type = map(string)
  default = {
    xyz = "mafyuh.xyz"
    com = "mafyuh.com"
    dev = "mafyuh.dev"
    io  = "mafyuh.io"
  }
}