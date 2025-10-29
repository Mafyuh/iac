data "bitwarden_secret" "tenancy_ocid" {
  id = "a33e6411-638e-4d3c-83be-b2a500299a9f"
}

data "bitwarden_secret" "user_ocid" {
  id = "7d0d0bce-d0e8-4bef-a5b9-b2a5002a5c42"
}

data "bitwarden_secret" "fingerprint" {
  id = "b15c13d7-ba84-4716-b46e-b2a5002ad2de"
}

data "bitwarden_secret" "oci_private_key" {
  id = "efd2db8f-4cb2-4031-ac2d-b2a500447bf4"
}

data "bitwarden_secret" "compartment_id" {
  id = "c6f7094d-c435-45af-ac40-b2a50039e2a8"
}

data "bitwarden_secret" "arm_subnet_id" {
  id = "85bd7668-0ce1-4dc1-a872-b2a5003b8bcd"
}

data "bitwarden_secret" "homelab_ip" {
  id = "bd5a4e06-fbfa-4550-975c-b2a7005600aa"
}

variable "access_token" {
  description = "Access Token for BWS"
  type        = string
  sensitive   = true
}
