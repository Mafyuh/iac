resource "oci_core_internet_gateway" "Internet-Gateway-NEW" {
  compartment_id = data.bitwarden_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/admin@mafyuh.com"
    "Oracle-Tags.CreatedOn" = "2023-06-06T00:48:50.966Z"
  }
  display_name = "Internet Gateway NEW"
  enabled      = "true"
  vcn_id       = oci_core_vcn.NEW.id
}

resource "oci_core_internet_gateway" "Internet-Gateway-vcn-20230309-0146" {
  compartment_id = data.bitwarden_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:13.449Z"
  }
  display_name = "Internet Gateway vcn-20230309-0146"
  enabled      = "true"
  vcn_id       = oci_core_vcn.vcn-20230309-0146.id
}
