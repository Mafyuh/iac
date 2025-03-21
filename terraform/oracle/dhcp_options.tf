resource oci_core_default_dhcp_options NEW {
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  display_name     = "Default DHCP Options for NEW"
  domain_name_type = "CUSTOM_DOMAIN"
  freeform_tags = {
  }
  manage_default_resource_id = "ocid1.dhcpoptions.oc1.iad.aaaaaaaad27kexcjznctiai643ufjj2wtx6bsyfalfbqhoq6lclkzkdoyhwa"
  options {
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "vcn06052048.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}

resource oci_core_default_dhcp_options Default-DHCP-Options-for-vcn-20230309-0146 {
  compartment_id = data.bitwarden-secrets_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:11.494Z"
  }
  display_name     = "Default DHCP Options for vcn-20230309-0146"
  domain_name_type = "CUSTOM_DOMAIN"
  manage_default_resource_id = "ocid1.dhcpoptions.oc1.iad.aaaaaaaanoloodozl6y2kxggd6ug7kxdolslpftyhxx26pvxyf47abvtzjaa"
  options {
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "vcn03090152.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}
