terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "google" {
 credentials = "${file(var.gcp_credentials_path)}"
 project     = "${var.project_name}"
 region      = "${var.region}"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

//data "digitalocean_ssh_key" "terraform" {
//  name = "terraform"
//}
