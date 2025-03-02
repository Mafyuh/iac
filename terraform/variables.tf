variable "s3_endpoint" {
  description = "Endpoint for S3 storage"
  type        = string
}

variable "access_token" {
  description = "Access Token for BWS"
  type        = string
  sensitive   = true
}