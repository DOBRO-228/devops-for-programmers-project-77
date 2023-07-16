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
