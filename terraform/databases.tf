resource "digitalocean_database_cluster" "database_cluster" {
  name       = "postgres-cluster"
  engine     = "pg"
  version    = "15"
  region     = var.signapore_region
  size       = "db-s-1vcpu-1gb"
  node_count = 1
}
