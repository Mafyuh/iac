data "bitwarden_secret" "npm_ip_address" {
  id = "47ef68aa-32a9-45b0-835d-b2080006ce38"
}

data "bitwarden_secret" "kasm_ip" {
  id = "0bc3c1a3-fc48-48ce-85c5-b2080007136a"
}

data "bitwarden_secret" "vlan_gateway" {
  id = "af0ed579-05f8-405f-b0f3-b208000620ca"
}

data "bitwarden_secret" "ubu_ip" {
  id = "d8017351-7a11-42e6-9e8d-b208000739b8"
}

data "bitwarden_secret" "k3s_master1_ip" {
  id = "528104e1-2186-4d57-ae86-b27e01263972"
}

data "bitwarden_secret" "k3s_master2_ip" {
  id = "71051171-a582-45e7-a239-b27e01269ef2"
}

data "bitwarden_secret" "k3s_master3_ip" {
  id = "b48234d4-1b52-43e2-bab9-b27e0126bfdb"
}
