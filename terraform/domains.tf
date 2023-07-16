resource "digitalocean_domain" "domain" {
  name       = var.domain_name
  ip_address = digitalocean_loadbalancer.lb.ip
}
