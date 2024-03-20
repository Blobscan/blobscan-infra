resource "google_compute_address" "static" {
  name = terraform.workspace

  labels = {
    app = "swarm"
    env = "prod"
  }
}


resource "google_compute_instance" "swarm_node" {
    name         = terraform.workspace
    machine_type = "${var.instance_type}"
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
    app = "swarm"
    env = "prod"
  }
}

output "ip" {
 value = "${google_compute_instance.swarm_node.network_interface.0.access_config.0.nat_ip}"
}
