terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "dobro_local"
}

data "digitalocean_certificate" "cert" {
  name    = "dobro-228"
}

resource "digitalocean_loadbalancer" "lb" {
  name   = "load-balancer"
  region = var.signapore_region
  redirect_http_to_https = true

  forwarding_rule {

    entry_port     = 443
    entry_protocol = "https"

    target_port     = 3000
    target_protocol = "http"
  
    certificate_id = data.digitalocean_certificate.cert.id

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

resource "digitalocean_database_cluster" "database_cluster" {
  name       = "postgres-cluster"
  engine     = "pg"
  version    = "15"
  region     = var.signapore_region
  size       = "db-s-1vcpu-1gb"
  node_count = 1
}

resource "digitalocean_droplet" "web-1" {
  image              = var.ubuntu_image
  name               = "web-1"
  region             = var.signapore_region
  size               = var.size
  private_networking = false

  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
}

resource "digitalocean_droplet" "web-2" {
  image              = var.ubuntu_image
  name               = "web-2"
  region             = var.signapore_region
  size               = var.size
  private_networking = false

  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }
}

resource "digitalocean_domain" "domain" {
  name       = "228.dobro-228.ru"
  ip_address = digitalocean_loadbalancer.lb.ip
}

output "droplets" {
  value =  [
    digitalocean_droplet.web-1,
    digitalocean_droplet.web-2
  ]
}

output "db_cluster" {
  value = digitalocean_database_cluster.database_cluster
  sensitive = true
}
