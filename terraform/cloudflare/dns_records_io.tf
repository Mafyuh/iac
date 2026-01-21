resource "cloudflare_dns_record" "io_go" {
  content = data.bitwarden-secrets_secret.arm_oci_vm_ip.value
  name    = "go.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_jelly" {
  content = data.bitwarden-secrets_secret.vps_oci_vm_ip.value
  name    = "jelly.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_kuma" {
  content = data.bitwarden-secrets_secret.arm_oci_vm_ip.value
  name    = "kuma.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_links" {
  content = data.bitwarden-secrets_secret.arm_oci_vm_ip.value
  name    = "links.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_local_wildcard" {
  content = "10.69.69.200"
  name    = "*.local.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_request" {
  content = data.bitwarden-secrets_secret.arm_oci_vm_ip.value
  name    = "request.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_x" {
  content = data.bitwarden-secrets_secret.arm_oci_vm_ip.value
  name    = "x.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_chat" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "chat.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_kasm" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "kasm.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_wildcard" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "*.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_mafyuh_io" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = var.domains["io"]
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail2" {
  content = "protonmail2.domainkey.do3ms56zchvtm6sjemsbc5v2e3ednpsah4nnxa75siw5n7oowueya.domains.proton.ch"
  name    = "protonmail2._domainkey.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail3" {
  content = "protonmail3.domainkey.do3ms56zchvtm6sjemsbc5v2e3ednpsah4nnxa75siw5n7oowueya.domains.proton.ch"
  name    = "protonmail3._domainkey.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail_key" {
  content = "protonmail.domainkey.do3ms56zchvtm6sjemsbc5v2e3ednpsah4nnxa75siw5n7oowueya.domains.proton.ch"
  name    = "protonmail._domainkey.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_prox" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "prox.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_sab" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "sab.${var.domains["io"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail_mx" {
  content  = "mailsec.protonmail.ch"
  name     = var.domains["io"]
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail_mx_10" {
  content  = "mail.protonmail.ch"
  name     = var.domains["io"]
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_dmarc" {
  content = "v=DMARC1; p=none"
  name    = "_dmarc.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_hcp_verification" {
  content = "hcp-domain-verification=ff6c13e9a8728cc4f929db42bffe7a3cd75afe82ac7282042e5d565504984d51"
  name    = var.domains["io"]
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_spf_record" {
  content = "v=spf1 include:_spf.protonmail.ch mx ~all"
  name    = var.domains["io"]
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_protonmail_verification" {
  content = "protonmail-verification=a89583b3c8939a627b53a95a699f91de657807e1"
  name    = var.domains["io"]
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}

resource "cloudflare_dns_record" "io_pbx" {
  content = data.bitwarden-secrets_secret.pbx_ip.value
  name    = "pbx.${var.domains["io"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden-secrets_secret.cf_io_zone_id.value
}
