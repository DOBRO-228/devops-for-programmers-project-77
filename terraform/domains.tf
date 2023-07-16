resource "digitalocean_domain" "domain" {
  name       = "228.dobro-228.ru"
  ip_address = digitalocean_loadbalancer.lb.ip
}
