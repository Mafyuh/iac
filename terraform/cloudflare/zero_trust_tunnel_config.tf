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
        hostname       = "pg.${var.domains["dev"]}"
        service        = "http://10.20.10.100:5050"
        path           = ""
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
        hostname       = "couch.${var.domains["dev"]}"
        service        = "http://10.20.10.100:5984"
        path           = ""
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
        hostname       = "kasm.${var.domains["io"]}"
        service        = "https://10.69.69.189"
        path           = ""
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
        hostname       = "stats.${var.domains["dev"]}"
        service        = "http://10.69.69.199:3000"
        path           = ""
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
        hostname       = "auth.${var.domains["io"]}"
        service        = "https://10.0.0.210:443"
        path           = ""
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
        hostname       = "prox.${var.domains["io"]}"
        service        = "https://10.0.0.30:8006"
        path           = ""
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
        hostname       = "home.${var.domains["dev"]}"
        service        = "https://10.0.0.210:443"
        path           = ""
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
        hostname       = "chat.${var.domains["io"]}"
        service        = "http://10.20.10.75:3000"
        path           = ""
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
        hostname       = "prom-metrics.${var.domains["dev"]}"
        service        = "http://10.69.69.2:3000"
        path           = ""
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
        hostname       = "*.${var.domains["io"]}"
        service        = "https://10.0.0.210:443"
        path           = ""
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
        hostname       = "*.${var.domains["dev"]}"
        service        = "https://10.0.0.210:443"
        path           = ""
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