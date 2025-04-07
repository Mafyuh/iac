resource "cloudflare_zero_trust_tunnel_cloudflared_config" "main_tunnel" {
  account_id = data.bitwarden_secret.cf_account_id.value
  tunnel_id  = "c68b2785-4489-4a5b-a265-4cb72d2e2625"

  lifecycle {
    ignore_changes = [
      source
    ]
  }

  config = {
    ingress = [
      {
        hostname       = "kasm.${var.io_domain}"
        service        = "http://${var.npm_ip_address}:80"
        origin_request = {
          no_tls_verify            = false
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "stats.${var.dev_domain}"
        service        = "http://${var.npm_ip_address}:80"
        origin_request = {
          no_tls_verify            = true
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "auth.${var.io_domain}"
        service        = "https://${var.k3s_nginx_ip_address}:443"
        origin_request = {
          no_tls_verify            = true
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "prox.${var.io_domain}"
        service        = "https://10.0.0.30:8006"
        origin_request = {
          no_tls_verify            = true
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "home.${var.dev_domain}"
        service        = "http://10.0.0.45:8123"
        origin_request = {
          no_tls_verify            = false
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "chat.${var.io_domain}"
        service        = "http://10.0.0.25:3000"
        origin_request = {
          no_tls_verify            = false
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "prom-metrics.${var.dev_domain}"
        service        = "http://10.69.69.2:5000"
        origin_request = {
          no_tls_verify            = false
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "*.${var.io_domain}"
        service        = "https://${var.k3s_nginx_ip_address}:443"
        origin_request = {
          no_tls_verify            = true
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        hostname       = "*.${var.dev_domain}"
        service        = "https://${var.k3s_nginx_ip_address}:443"
        origin_request = {
          no_tls_verify            = true
          origin_server_name       = ""
          disable_chunked_encoding = false
          http2_origin             = false
          tcp_keep_alive           = 300
          keep_alive_connections   = 100
          keep_alive_timeout       = 90
          tls_timeout              = 10
          connect_timeout          = 30
          http_host_header         = ""
          proxy_type               = ""
          ca_pool                  = ""
          no_happy_eyeballs        = false
          access = {
            aud_tag = [""]
            team_name = "mafyuh"
            required = false
          }
        }
      },
      {
        service = "http_status:404"
      }
    ]
    warp_routing = {
      enabled = false
    }
  }
}