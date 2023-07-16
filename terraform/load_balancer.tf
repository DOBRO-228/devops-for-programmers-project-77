resource "digitalocean_loadbalancer" "lb" {
  name                   = "load-balancer"
  region                 = var.signapore_region
  redirect_http_to_https = true

  forwarding_rule {
    certificate_id = data.digitalocean_certificate.cert.id
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 3000
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 3000
    target_protocol = "http"
  }

  healthcheck {
    port     = 3000
    protocol = "http"
    path     = "/"
  }

  droplet_ids = [
    digitalocean_droplet.web-1.id,
    digitalocean_droplet.web-2.id
  ]
}
