resource "oci_core_security_list" "service_load_balancers" {
  compartment_id = data.bitwarden-secrets_secret.compartment_ocid.value
  display_name   = "oke-vcn-lan-svclbseclist"
  vcn_id         = oci_core_vcn.oke.id

  ingress_security_rules {
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 10256
      max = 10256
    }
  }

  egress_security_rules {
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 30456
      max = 30456
    }
  }

  egress_security_rules {
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 31350
      max = 31350
    }
  }
}

resource "oci_core_security_list" "workers_and_pods" {
  compartment_id = data.bitwarden-secrets_secret.compartment_ocid.value
  display_name   = "oke-vcn-lan-nodeseclist"
  vcn_id         = oci_core_vcn.oke.id

  egress_security_rules {
    description      = "Allow pods on one worker node to communicate with pods on other worker nodes"
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  egress_security_rules {
    description      = "Access to Kubernetes API Endpoint"
    destination      = "10.100.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    description      = "Kubernetes worker to control plane communication"
    destination      = "10.100.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 12250
      max = 12250
    }
  }

  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.100.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "1"
    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    description      = "Allow nodes to communicate with OKE to ensure correct start-up and continued functioning"
    destination      = data.oci_core_services.all_iad_services.services[0].cidr_block
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    description      = "Worker Nodes access to Internet"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

  ingress_security_rules {
    description = "Allow pods on one worker node to communicate with pods on other worker nodes"
    source      = "10.100.10.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "all"
  }

  ingress_security_rules {
    description = "Path discovery"
    source      = "10.100.0.0/28"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    description = "TCP access from Kubernetes Control Plane"
    source      = "10.100.0.0/28"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
  }

  ingress_security_rules {
    description = "Inbound SSH traffic to worker nodes"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    source      = "10.100.20.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 10256
      max = 10256
    }
  }

  ingress_security_rules {
    source      = "10.100.20.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 30456
      max = 30456
    }
  }

  ingress_security_rules {
    source      = "10.100.20.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 31350
      max = 31350
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.home_network_cidrs
    content {
      description = "Home UniFi LAN to worker nodes"
      source      = ingress_security_rules.value
      source_type = "CIDR_BLOCK"
      protocol    = "all"
    }
  }
}

resource "oci_core_security_list" "api_endpoint" {
  compartment_id = data.bitwarden-secrets_secret.compartment_ocid.value
  display_name   = "oke-vcn-lan-k8sApiEndpoint"
  vcn_id         = oci_core_vcn.oke.id

  egress_security_rules {
    description      = "Allow Kubernetes Control Plane to communicate with OKE"
    destination      = data.oci_core_services.all_iad_services.services[0].cidr_block
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    description      = "All traffic to worker nodes"
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
  }

  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.100.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "1"
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    description = "External access to Kubernetes API endpoint"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    source      = "10.100.10.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    description = "Kubernetes worker to control plane communication"
    source      = "10.100.10.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "6"
    tcp_options {
      min = 12250
      max = 12250
    }
  }

  ingress_security_rules {
    description = "Path discovery"
    source      = "10.100.10.0/24"
    source_type = "CIDR_BLOCK"
    protocol    = "1"
    icmp_options {
      type = 3
      code = 4
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.home_network_cidrs
    content {
      description = "Home UniFi LAN to Kubernetes API"
      source      = ingress_security_rules.value
      source_type = "CIDR_BLOCK"
      protocol    = "6"
      tcp_options {
        min = 6443
        max = 6443
      }
    }
  }
}
