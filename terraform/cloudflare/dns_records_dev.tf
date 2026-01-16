resource "cloudflare_dns_record" "dev_external" {
  content = "9516dded-1ccc-4f32-b9ed-3691ae265523.cfargotunnel.com"
  name    = "external.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_links" {
  content = data.bitwarden_secret.arm_oci_vm_ip.value
  name    = "links.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_local_wildcard" {
  content = "10.0.0.218"
  name    = "*.local.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_local" {
  content = "10.0.0.210"
  name    = "local.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_n8n" {
  content = data.bitwarden_secret.arm_oci_vm_ip.value
  name    = "n8n.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_sync" {
  content = data.bitwarden_secret.arm_oci_vm_ip.value
  name    = "sync.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_vault" {
  content = data.bitwarden_secret.arm_oci_vm_ip.value
  name    = "vault.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_docs" {
  content = "mafyuh.github.io/iac-wiki"
  name    = "docs.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_domainconnect" {
  content = "connect.domains.google.com"
  name    = "_domainconnect.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_home" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "home.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_root" {
  content = "mafyuh.github.io"
  name    = var.domains["dev"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_prom_metrics" {
  content = "c68b2785-4489-4a5b-a265-4cb72d2e2625.cfargotunnel.com"
  name    = "prom-metrics.${var.domains["dev"]}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_protonmail2" {
  content = "protonmail2.domainkey.dg2yuwzjnoghdjxb7flm3iih5jx44deqtobjlqrjdpmiosiyvdpsa.domains.proton.ch"
  name    = "protonmail2._domainkey.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_protonmail3" {
  content = "protonmail3.domainkey.dg2yuwzjnoghdjxb7flm3iih5jx44deqtobjlqrjdpmiosiyvdpsa.domains.proton.ch"
  name    = "protonmail3._domainkey.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_protonmail_key" {
  content = "protonmail.domainkey.dg2yuwzjnoghdjxb7flm3iih5jx44deqtobjlqrjdpmiosiyvdpsa.domains.proton.ch"
  name    = "protonmail._domainkey.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_mx_20" {
  content  = "mailsec.protonmail.ch"
  name     = var.domains["dev"]
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_mx_10" {
  content  = "mail.protonmail.ch"
  name     = var.domains["dev"]
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_dmarc" {
  content = "v=DMARC1; p=none"
  name    = "_dmarc.${var.domains["dev"]}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_spf" {
  content = "v=spf1 include:_spf.protonmail.ch mx ~all"
  name    = var.domains["dev"]
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}

resource "cloudflare_dns_record" "dev_protonmail_verification" {
  content = "protonmail-verification=65e77a1a975eba119019f5c0a28d84e4a11183b8"
  name    = var.domains["dev"]
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_dev_zone_id.value
}
