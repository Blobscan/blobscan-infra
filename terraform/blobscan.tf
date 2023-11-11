// Static external IP
resource "google_compute_address" "static" {
  name = terraform.workspace

  labels = {
    app = "blobscan"
    env = terraform.workspace == "blobscan-staging" ? "staging" : "production"
  }
}

// Define VM resource
resource "google_compute_instance" "instance_with_ip" {
    name         = terraform.workspace
    machine_type = "e2-small"
    zone         = "${var.zone}"

    boot_disk {
        initialize_params{
            image = "debian-cloud/debian-11"
            size = 100
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
    env = terraform.workspace == "blobscan-staging" ? "staging" : "production"
  }
}

// Expose IP of VM
output "ip" {
 value = "${google_compute_instance.instance_with_ip.network_interface.0.access_config.0.nat_ip}"
}
