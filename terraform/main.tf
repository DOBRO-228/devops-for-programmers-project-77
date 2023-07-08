terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  // Имя под которым ключ сохранён в DO
  // https://cloud.digitalocean.com/account/security
  name = "dobro_local"
}

resource "digitalocean_certificate" "cert" {
  name    = "ssl-cert"
  type    = "lets_encrypt"
  domains = ["dobro-228.ru", "228.dobro-228.ru"]
}


// Создание балансировщика нагрузки
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer
resource "digitalocean_loadbalancer" "lb" {
  name   = "load-balancer"
  region = var.signapore_region
  redirect_http_to_https = true

  forwarding_rule {

    entry_port     = 443
    entry_protocol = "https"

    // Порт по которому балансировщик передает запросы (на другие сервера)
    target_port     = 8080
    target_protocol = "http"
  
    certificate_id = digitalocean_certificate.cert.id

  }

  // Порт, протокол, путь по которому балансировщик проверяет, что дроплет жив и принимает запросы
  healthcheck {
    port     = 8080
    protocol = "http"
    path     = "/"
  }

  depends_on = [
    digitalocean_droplet.web-1,
    digitalocean_droplet.web-2
  ]

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
  # database   = var.database_name
  # user       = var.database_user
  # password   = var.database_user_password

  depends_on = [
    digitalocean_droplet.web-1,
    digitalocean_droplet.web-2
  ]
}

// Создаём дроплет
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet
resource "digitalocean_droplet" "web-1" {
  image              = var.ubuntu_image
  name               = "web-1"
  region             = var.signapore_region
  size               = var.size
  private_networking = true

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
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
  private_networking = true

  // Добавление приватного ключа на создаваемый сервер
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
