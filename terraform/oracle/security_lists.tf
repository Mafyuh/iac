resource "oci_core_default_security_list" "Default-Security-List-for-NEW" {
  compartment_id = data.bitwarden_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/admin@mafyuh.com"
    "Oracle-Tags.CreatedOn" = "2023-06-06T00:48:49.328Z"
  }
  display_name = "Default Security List for NEW"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "https connections"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    description = "http connections"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "80"
      min = "80"
    }
  }
  ingress_security_rules {
    description = "NPM WEBUI"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "81"
      min = "81"
    }
  }
  ingress_security_rules {
    description = "Postgres"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "5432"
      min = "5432"
    }
  }
  ingress_security_rules {
    description = "SSH"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "2424"
      min = "2424"
    }
  }
  manage_default_resource_id = oci_core_vcn.NEW.default_security_list_id
}

resource "oci_core_default_security_list" "Default-Security-List-for-vcn-20230309-0146" {
  compartment_id = data.bitwarden_secret.compartment_id.value
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-03-09T06:52:11.494Z"
  }
  display_name = "Default Security List for vcn-20230309-0146"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  freeform_tags = {
  }
  ingress_security_rules {
    description = "SSH"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  ingress_security_rules {
    description = "SSH"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "2424"
      min = "2424"
    }
  }
  ingress_security_rules {
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "http connections"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    tcp_options {
      max = "80"
      min = "80"
    }
  }
  ingress_security_rules {
    description = "https allow"
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    tcp_options {
      max = "443"
      min = "443"
    }
  }
  ingress_security_rules {
    description = "NPM WEBUI"
    protocol    = "6"
    source      = "${data.bitwarden_secret.homelab_ip.value}/32"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "81"
      min = "81"
    }
  }
  manage_default_resource_id = oci_core_vcn.vcn-20230309-0146.default_security_list_id
}
