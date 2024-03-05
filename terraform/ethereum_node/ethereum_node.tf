resource "google_compute_address" "static" {
  name = terraform.workspace

  labels = {
    app = "ethereum"
    env = "prod"
    network = "${var.network}"
  }
}


resource "google_compute_instance" "ethereum_node" {
    name         = terraform.workspace
    machine_type = "${var.instance_type}"
    // c3-standard-4 or n2-standard-4"
    zone         = "${var.zone}"
    tags         = ["allow-ssh", "allow-eth-traffic"]

    boot_disk {
        initialize_params{
            image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
            size = "${var.disk_size}"
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
    app = "ethereum"
    env = "prod"
    network = "${var.network}"
  }
}

output "ip" {
 value = "${google_compute_instance.ethereum_node.network_interface.0.access_config.0.nat_ip}"
}
