variable "s3_endpoint" {
  description = "Endpoint for S3 storage"
  type        = string
}

variable "access_token" {
  description = "Access Token for BWS"
  type        = string
  sensitive   = true
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