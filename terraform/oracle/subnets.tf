resource oci_core_subnet NEW {
  cidr_block     = "10.0.0.0/24"
  compartment_id = data.bitwarden_secret.compartment_id.value
  dhcp_options_id = oci_core_default_dhcp_options.NEW.id
  display_name    = "NEW"
  dns_label       = "subnet06052048"
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.NEW.default_route_table_id
  security_list_ids = [
    oci_core_vcn.NEW.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.NEW.id
}

resource oci_core_subnet subnet-20230309-0146 {
  cidr_block     = "10.0.0.0/24"
  compartment_id = data.bitwarden_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:16.324Z"
  }
  dhcp_options_id = oci_core_default_dhcp_options.Default-DHCP-Options-for-vcn-20230309-0146.id
  display_name    = "subnet-20230309-0146"
  dns_label       = "subnet03090152"
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.vcn-20230309-0146.default_route_table_id
  security_list_ids = [
    oci_core_vcn.vcn-20230309-0146.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.vcn-20230309-0146.id
}