resource "cloudflare_dns_record" "local_com_wildcard" {
  content = "${var.k3s_nginx_ip_address}"
  name    = "*.local.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_wildcard" {
  content = "4b2e694f-f394-45bf-ade6-4e2c534e30b9.cfargotunnel.com"
  name    = "*.${var.com_domain}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "mafyuh_com" {
  content = "mafyuh.github.io"
  name    = "${var.com_domain}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail2" {
  content = "protonmail2.domainkey.dmnyofytcnmddqip6vmccjuink6qpxfc4dsdgdh3gni4yxgkh63ua.domains.proton.ch"
  name    = "protonmail2._domainkey.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail3" {
  content = "protonmail3.domainkey.dmnyofytcnmddqip6vmccjuink6qpxfc4dsdgdh3gni4yxgkh63ua.domains.proton.ch"
  name    = "protonmail3._domainkey.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail_key" {
  content = "protonmail.domainkey.dmnyofytcnmddqip6vmccjuink6qpxfc4dsdgdh3gni4yxgkh63ua.domains.proton.ch"
  name    = "protonmail._domainkey.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail_mx" {
  content  = "mailsec.protonmail.ch"
  name     = "${var.com_domain}"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail_mx_10" {
  content  = "mail.protonmail.ch"
  name     = "${var.com_domain}"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  zone_id  = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail_dkim" {
  content = "\"v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78k\" \"m4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB\""
  name    = "cf2024-1._domainkey.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_dmarc" {
  content = "v=DMARC1; p=none"
  name    = "_dmarc.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_github_pages" {
  content = "041066d465b10463fddd34bbd9ecfd"
  name    = "_github-pages-challenge-mafyuh.${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_google_verification" {
  content = "google-site-verification=xP-_n94kxaq7KI_eD4E58kqjYtnztyzQ9NeDZXxDPts"
  name    = "${var.com_domain}"
  proxied = false
  ttl     = 3600
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_ms_verification" {
  content = "MS=ms65994231"
  name    = "${var.com_domain}"
  proxied = false
  ttl     = 3600
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_spf_record" {
  content = "v=spf1 include:_spf.protonmail.ch mx ~all"
  name    = "${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}

resource "cloudflare_dns_record" "com_protonmail_verification" {
  content = "protonmail-verification=cb0ab2aa9e9510223fe9e90a1821a9d640859f4f"
  name    = "${var.com_domain}"
  proxied = false
  ttl     = 1
  type    = "TXT"
  zone_id = data.bitwarden_secret.cf_com_zone_id.value
}