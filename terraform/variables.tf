variable "s3_endpoint" {
  description = "Endpoint for S3 storage"
  type        = string
}


variable "grafana_auth" {
  description = "Service Account token"
  type        = string
  sensitive   = true
}

variable "grafana_url" {
  description = "Grafana Url"
  type        = string
  sensitive   = true
}

variable "access_token" {
  description = "Access Token for BWS"
  type        = string
  sensitive   = true
}