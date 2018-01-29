resource "digitalocean_droplet" "blog_duplex" {
  image = "debian-9-x64"
  name = "supercarrier"
  region = "sfo2"
  size = "1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
}

resource "digitalocean_domain" "BLOG_URL_ONE_NAME" {
  name = "[BLOG_ONE_URL]"
  ip_address = "${digitalocean_droplet.blog_duplex.ipv4_address}"
}

resource "digitalocean_domain" "BLOG_URL_TWO_NAME" {
  name = "[BLOG_TWO_URL]"
  ip_address = "${digitalocean_droplet.blog_duplex.ipv4_address}"
}

resource "digitalocean_record" "CNAME_BLOG_ONE_NAME" {
  domain = "${digitalocean_domain.BLOG_URL_ONE_NAME.name}"
  type = "CNAME"
  name = "www"
  value = "@"
}

resource "digitalocean_record" "CNAME_BLOG_TWO_NAME" {
  domain = "${digitalocean_domain.BLOG_URL_TWO_NAME.name}"
  type = "CNAME"
  name = "www"
  value = "@"
}
