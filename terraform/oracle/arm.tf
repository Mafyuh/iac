data "bitwarden-secrets_secret" "compartment_id" {
  id = "c6f7094d-c435-45af-ac40-b2a50039e2a8"
}

data "bitwarden-secrets_secret" "arm_subnet_id" {
  id = "85bd7668-0ce1-4dc1-a872-b2a5003b8bcd"
}

resource "oci_core_instance" "arm" {
  availability_domain = "nWCj:US-ASHBURN-AD-1"
  compartment_id      = data.bitwarden-secrets_secret.compartment_id.value
  display_name        = "ARM"

  shape = "VM.Standard.A1.Flex"

  shape_config {
    memory_in_gbs = 24
    ocpus = 4
    vcpus = 4
  }

  create_vnic_details {
    subnet_id        = data.bitwarden-secrets_secret.arm_subnet_id.value
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagbgiy3w3psyvqarm5lcyjyort7ufmcx7qisizxsae3rdm6k75odq"
    boot_volume_size_in_gbs = 149
  }
  launch_options {
    boot_volume_type = "PARAVIRTUALIZED"
    network_type = "PARAVIRTUALIZED"
    firmware = "UEFI_64"
    is_consistent_volume_naming_enabled = true
    is_pv_encryption_in_transit_enabled = false
  }
}

