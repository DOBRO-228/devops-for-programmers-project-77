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
