// Static external IP
resource "google_compute_address" "static" {
  name = terraform.workspace

  labels = {
    app = "blobscan"
    env = "${var.env}"
  }
}

// Define VM resource
resource "google_compute_instance" "blobscan" {
    name         = terraform.workspace
    machine_type = "${var.vm_size}"
    zone         = "${var.zone}"
    tags         = ["allow-ssh", "allow-eth-traffic"]

    boot_disk {
        initialize_params{
            image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
            size = 100
            type = "pd-balanced"
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_key_path)}"
    }

    network_interface {
        network = "default"
        access_config {
            nat_ip = "${google_compute_address.static.address}"
        }
    }

  labels = {
    app = "blobscan"
    env = "${var.env}"
  }
}

# fetching already created DNS zone
data "google_dns_managed_zone" "blobscan_zone" {
  name = "blobscan"
}

resource "google_dns_record_set" "blobscan_network_domain" {
  count        = var.network == "mainnet" ? 0 : 1
  name         = "${var.domain}."
  managed_zone = data.google_dns_managed_zone.blobscan_zone.name
  type         = "CNAME"
  ttl          = 300
  rrdatas = [
    "cname.vercel-dns.com."
  ]
}

resource "google_dns_record_set" "blobscan_api" {
  name         = "api.${var.domain}."
  managed_zone = data.google_dns_managed_zone.blobscan_zone.name
  type         = "A"
  ttl          = 300
  rrdatas = [
    google_compute_instance.blobscan.network_interface[0].access_config[0].nat_ip
  ]
}

output "ip" {
 value = "${google_compute_instance.blobscan.network_interface.0.access_config.0.nat_ip}"
}

output "vm_private_ip" {
  value = google_compute_instance.blobscan.network_interface[0].network_ip
  description = "The private IP address of the VM"
}

output "domain_api" {
 value = "${google_dns_record_set.blobscan_api.name}"
}

output "domain_web" {
 value = length(google_dns_record_set.blobscan_network_domain) > 0 ? google_dns_record_set.blobscan_network_domain[0].name : ""
}
