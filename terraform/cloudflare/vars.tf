variable "domains" {
  type = map(string)
}

variable "npm_ip_address" {
  type        = string
  default     = "10.69.69.200"
}

variable "k3s_nginx_ip_address" {
  type        = string
  default     = "10.69.69.220"
}