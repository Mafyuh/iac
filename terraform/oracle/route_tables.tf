resource "oci_core_default_route_table" "Default-Route-Table-for-NEW" {
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/admin@mafyuh.com"
    "Oracle-Tags.CreatedOn" = "2023-06-06T00:48:49.328Z"
  }
  display_name = "Default Route Table for NEW"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.NEW.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.Internet-Gateway-NEW.id
  }
}

resource "oci_core_default_route_table" "Default-Route-Table-for-vcn-20230309-0146" {
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:11.494Z"
  }
  display_name = "Default Route Table for vcn-20230309-0146"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.vcn-20230309-0146.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.Internet-Gateway-vcn-20230309-0146.id
  }
}
