data "bitwarden-secrets_secret" "cf_xyz_zone_id" {
  id = "1a739b7a-22e1-4fc4-9439-b2b7006f85f8"
}

data "bitwarden-secrets_secret" "cf_com_zone_id" {
  id = "b9a32aa6-5735-4ba6-adc1-b2b7007b7362"
}

data "bitwarden-secrets_secret" "cf_dev_zone_id" {
  id = "fe1c3898-ebc5-44d6-ac05-b2b7007cd71a"
}

data "bitwarden-secrets_secret" "cf_io_zone_id" {
  id = "bbba9ae9-0ba9-462f-8b7d-b2b7014fbb83"
}
data "bitwarden-secrets_secret" "arm_oci_vm_ip" {
  id = "6f9cef86-eb39-4e05-8c5b-b23e001e6170"
}

data "bitwarden-secrets_secret" "vps_oci_vm_ip" {
  id = "fd916db6-314b-440f-8378-b2b70150c924"
}

data "bitwarden-secrets_secret" "cf_account_id" {
  id = "c37639ff-ffd3-41cc-b875-b2b7012859d7"
}

data "bitwarden-secrets_secret" "pbx_ip" {
  id = "34c5c2f3-541f-41de-bb25-b309001f9253"
}

data "bitwarden-secrets_secret" "cloudflare_api_key" {
  id = "87e2b23c-f62d-4b6d-8a3a-b2e1018983ac"
}
