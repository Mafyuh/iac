resource oci_core_vcn NEW {
  cidr_blocks = [
    "10.0.0.0/16",
  ]
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/admin@mafyuh.com"
    "Oracle-Tags.CreatedOn" = "2023-06-06T00:48:49.328Z"
  }
  display_name = "NEW"
  dns_label    = "vcn06052048"
}

resource oci_core_vcn vcn-20230309-0146 {
  cidr_blocks = [
    "10.0.0.0/16",
  ]
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:11.494Z"
  }
  display_name = "vcn-20230309-0146"
  dns_label    = "vcn03090152"
}