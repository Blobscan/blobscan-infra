resource "digitalocean_database_cluster" "blobscan" {
  name         = "blobscan-${var.network}-${var.env}"
  engine       = "pg"
  version      = "15"
  size         = "${var.database_size}"
  storage_size_mib = 61440
  region       = "${var.do_region}"
  node_count   = 1
  tags = ["blobscan", "${var.env}", "${var.network}"]
}

output "db_host" {
 value = "${digitalocean_database_cluster.blobscan.host}"
}

output "db_port" {
 value = "${digitalocean_database_cluster.blobscan.port}"
}
