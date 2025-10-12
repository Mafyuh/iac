## ARM VM
resource oci_core_instance arm {
  agent_config {
    are_all_plugins_disabled = "false"
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }
  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = "nWCj:US-ASHBURN-AD-1"
  compartment_id = data.bitwarden_secret.compartment_id.value
  create_vnic_details {
    assign_public_ip = "true"
    defined_tags = {
      "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
      "Oracle-Tags.CreatedOn" = "2023-08-09T04:55:03.237Z"
    }
    display_name = "instance-20230809-0455"
    freeform_tags = {
    }
    hostname_label = "instance-20230809-0455"
    private_ip = "10.0.0.56"
    skip_source_dest_check = "true"
    subnet_id              = oci_core_subnet.NEW.id
  }
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/mafyuhh@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-08-09T04:55:03.054Z"
  }
  display_name = "ARM"
  extended_metadata = {
  }
  fault_domain = "FAULT-DOMAIN-1"
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    is_pv_encryption_in_transit_enabled = "false"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "24"
    nvmes                     = "0"
    ocpus                     = "4"
    vcpus                     = "4"
  }
  source_details {
    boot_volume_size_in_gbs = "149"
    boot_volume_vpus_per_gb = "10"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagbgiy3w3psyvqarm5lcyjyort7ufmcx7qisizxsae3rdm6k75odq"
    source_type = "image"
  }
  state = "RUNNING"
}