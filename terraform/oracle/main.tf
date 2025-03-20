provider "oci" {
  tenancy_ocid = data.bitwarden-secrets_secret.tenancy_ocid.value
  user_ocid = data.bitwarden-secrets_secret.user_ocid.value
  private_key = data.bitwarden-secrets_secret.oci_private_key.value
  fingerprint = data.bitwarden-secrets_secret.fingerprint.value
  region = "us-ashburn-1"
}